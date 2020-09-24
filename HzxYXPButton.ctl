VERSION 5.00
Begin VB.UserControl HzxYXPButton 
   ClientHeight    =   450
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   1665
   DefaultCancel   =   -1  'True
   ScaleHeight     =   30
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   111
   ToolboxBitmap   =   "HzxYXPButton.ctx":0000
End
Attribute VB_Name = "HzxYXPButton"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private Type RECT
    Left As Long
    Top As Long
    Right As Long
    Bottom As Long
End Type

Private Type TrackMouseEvent
    cbSize As Long
    dwFlags As Long
    hwnd As Long
    dwHoverTime As Long
End Type

Private Type POINTAPI
    X As Long
    Y As Long
End Type

Private Type RGBTRIPLE
    rgbBlue As Byte
    rgbGreen As Byte
    rgbRed As Byte
End Type

Private Type BITMAPINFOHEADER
    biSize As Long
    biWidth As Long
    biHeight As Long
    biPlanes As Integer
    biBitCount As Integer
    biCompression As Long
    biSizeImage As Long
    biXPelsPerMeter As Long
    biYPelsPerMeter As Long
    biClrUsed As Long
    biClrImportant As Long
End Type

Private Type BITMAPINFO
    bmiHeader As BITMAPINFOHEADER
    bmiColors As RGBTRIPLE
End Type


'1)DrawText
Enum DT
    DT_BOTTOM = &H8
    DT_CALCRECT = &H400
    DT_CENTER = &H1
    DT_CHARSTREAM = 4
    DT_DISPFILE = 6
    DT_EXPANDTABS = &H40
    DT_EXTERNALLEADING = &H200
    DT_INTERNAL = &H1000
    DT_LEFT = &H0
    DT_METAFILE = 5
    DT_NOCLIP = &H100
    DT_NOPREFIX = &H800
    DT_PLOTTER = 0
    DT_RASCAMERA = 3
    DT_RASDISPLAY = 1
    DT_RASPRINTER = 2
    DT_RIGHT = &H2
    DT_SINGLELINE = &H20
    DT_TABSTOP = &H80
    DT_TOP = &H0
    DT_VCENTER = &H4
    DT_WORDBREAK = &H10
    DT_WORD_ELLIPSIS = &H40000
    DT_END_ELLIPSIS = 32768
    DT_PATH_ELLIPSIS = &H4000
    DT_EDITCONTROL = &H2000
    '===================
    DT_INCENTER = DT_CENTER Or DT_VCENTER Or DT_SINGLELINE
End Enum

'2)DrawState
Enum DrawSt
    DST_COMPLEX = &H0
    DST_TEXT = &H1
    DST_PREFIXTEXT = &H2
    DST_ICON = &H3
    DST_BITMAP = &H4
    DSS_NORMAL = &H0
    DSS_UNION = &H10
    DSS_DISABLED = &H20
    DSS_MONO = &H80
    DSS_RIGHT = &H8000
End Enum
'3)WM
Enum WM_Message
    TME_LEAVE = &H2
    WM_TIMER = &H113
    WM_LBUTTONDOWN = &H201
    WM_LBUTTONDBLCLK = &H203
    WM_MYMSG = &H232
    WM_MOUSELEAVE = &H2A3
End Enum
'4)PlaySound
Enum SND
    SND_SYNC = &H0
    SND_ASYNC = &H1
    SND_NODEFAULT = &H2
    SND_LOOP = &H8
    SND_NOSTOP = &H10
    SND_NOWAIT = &H2000
    SND_FILENAME = &H20000
    SND_RESOURCE = &H40004
End Enum
'5)CreateFont
Enum Fnt
    FW_NORMAL = 400
    DEFAULT_CHARSET = 1
    OUT_DEFAULT_PRECIS = 0
    CLIP_DEFAULT_PRECIS = 0
    PROOF_QUALITY = 2
    DEFAULT_PITCH = 0
    LOGPIXELSY = 90
    COLOR_WINDOW = 5
End Enum
'6)CreatePen
Enum CP
    PS_SOLID = 0
    PS_DASH = 1
    PS_DOT = 2
    PS_DASHDOT = 3
    PS_DASHDOTDOT = 4
    PS_NULL = 5
    PS_INSIDEFRAME = 6
End Enum
'7)CreatePolygonRgn
Enum CPR
    ALTERNATE = 1
    BDR_SUNKENINNER = &H8
    BDR_RAISEDOUTER = &H1
    BDR_RAISEDINNER = &H4
    BDR_SUNKENOUTER = &H2
    BF_LEFT = &H1
    BF_RIGHT = &H4
    BF_TOP = &H2
    BF_BOTTOM = &H8
    BF_RECT = (BF_LEFT Or BF_TOP Or BF_RIGHT Or BF_BOTTOM)
End Enum
'8)
Enum sbAreaLayout
    LayoutLeft = 0
    LayoutRight = 1
    LayoutTop = 2
    LayoutBottom = 3
    CaptionOverPicture = 4
    PictureOverCaption = 5
End Enum
'9)
Enum sbLayout
    BottomLeft = 0
    BottomCenter = 1
    BottomRight = 2
    CenterLeft = 3
    CenterCenter = 4
    CenterRight = 5
    TopLeft = 6
    TopCenter = 7
    TopRight = 8
End Enum
'10)
Enum sbStyle
    WindowsXPButton = 0
    OfficeXPButton = 1
    OfficeXPButtonPro = 2
    IEButton = 3
    HintsUp_DownArrow = 4
    OfficeXPSeparator = 5
    OfficeXPHandle = 6
End Enum
'11)
Enum picScaleMe
    vbUser = 0
    vbTwips = 1
    vbPoints = 2
    vbPixels = 3
    vbCharacters = 4
    vbInches = 5
    vbMillimeters = 6
    vbCentimeters = 7
    vbHimetric = 8
    vbContainerPosition = 9
    vbContainerSize = 10
End Enum
'12)
Enum IconDrawMe
    DI_MASK = &H1
    DI_IMAGE = &H2
    DI_NORMAL = DI_MASK Or DI_IMAGE
End Enum
'13)Button
Enum ColorSets
    StandardColorSet = 0
    CustomColorSet = 1
End Enum
'14)True¡¢False


'15)
Enum InterfaceColors
    icMistyRose = &HE1E4FF
    icSlateGray = &H908070
    icDodgerBlue = &HFF901E
    icDeepSkyBlue = &HFFBF00
    icSpringGreen = &H7FFF00
    icForestGreen = &H228B22
    icGoldenrod = &H20A5DA
    icFirebrick = &H2222B2
End Enum
'16)
Enum PhotoEffects
    vbSrcCopy = &HCC0020
    vbSrcAnd = &H8800C6
    vbSrcInvert = &H660046
    vbSrcErase = &H440328
    vbSrcPaint = &HEE0086
End Enum
'17)
Enum PicFrameStyles
    Normal = 0
    Depressed = 1
    Heave = 2
End Enum
'18)
Enum IconStates
    Icon_Normal = 0
    Icon_Grey = 1
    Icon_Disabled = 2
End Enum

Private Declare Function GetWindowRect Lib "user32" (ByVal hwnd As Long, lpRect As RECT) As Long
Private Declare Function SetRect Lib "user32" (lpRect As RECT, ByVal X1 As Long, ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long) As Long
Private Declare Sub OleTranslateColor Lib "oleaut32.dll" (ByVal clr As Long, ByVal hPal As Long, ByRef lpcolorref As Long)
Private Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Private Declare Function SetPixel Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long, ByVal crColor As Long) As Long
Private Declare Function CreateSolidBrush Lib "gdi32" (ByVal crColor As Long) As Long
Private Declare Function DrawState Lib "user32" Alias "DrawStateA" (ByVal hdc As Long, ByVal hBrush As Long, ByVal lpDrawStateProc As Long, ByVal lParam As Long, ByVal wParam As Long, ByVal n1 As Long, ByVal n2 As Long, ByVal n3 As Long, ByVal n4 As Long, ByVal un As Long) As Long
Private Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
Private Declare Function FillRect Lib "user32" (ByVal hdc As Long, lpRect As RECT, ByVal hBrush As Long) As Long
Private Declare Function FrameRect Lib "user32" (ByVal hdc As Long, lpRect As RECT, ByVal hBrush As Long) As Long
Private Declare Function DrawText Lib "user32" Alias "DrawTextA" (ByVal hdc As Long, ByVal lpStr As String, ByVal nCount As Long, lpRect As RECT, ByVal wFormat As Long) As Long
Private Declare Function DrawFocusRect Lib "user32" (ByVal hdc As Long, lpRect As RECT) As Long
Private Declare Function TrackMouseEvent Lib "comctl32.dll" Alias "_TrackMouseEvent" (ByRef lpEventTrack As TrackMouseEvent) As Long
Private Declare Function SetTextColor Lib "gdi32" (ByVal hdc As Long, ByVal crColor As Long) As Long
Private Declare Function GetTextColor Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function MoveToEx Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long, lpPoint As POINTAPI) As Long
Private Declare Function LineTo Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long) As Long
Private Declare Function CreatePen Lib "gdi32" (ByVal nPenStyle As Long, ByVal nWidth As Long, ByVal crColor As Long) As Long
Private Declare Function CreatePolygonRgn Lib "gdi32" (lpPoint As Any, ByVal nCount As Long, ByVal nPolyFillMode As Long) As Long
Private Declare Function FillRgn Lib "gdi32" (ByVal hdc As Long, ByVal hRgn As Long, ByVal hBrush As Long) As Long
Private Declare Function DrawIconEx Lib "user32" (ByVal hdc As Long, ByVal xLeft As Long, ByVal yTop As Long, ByVal hIcon As Long, ByVal cxWidth As Long, ByVal cyWidth As Long, ByVal istepIfAniCur As Long, ByVal hbrFlickerFreeDraw As Long, ByVal diFlags As Long) As Long
Private Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function CreateCompatibleBitmap Lib "gdi32" (ByVal hdc As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long
Private Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal X As Long, ByVal Y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
Private Declare Function GetDIBits Lib "gdi32" (ByVal aHDC As Long, ByVal hBitmap As Long, ByVal nStartScan As Long, ByVal nNumScans As Long, lpBits As Any, lpBI As BITMAPINFO, ByVal wUsage As Long) As Long
Private Declare Function SetDIBitsToDevice Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long, ByVal dx As Long, ByVal dy As Long, ByVal SrcX As Long, ByVal SrcY As Long, ByVal Scan As Long, ByVal NumScans As Long, Bits As Any, BitsInfo As BITMAPINFO, ByVal wUsage As Long) As Long
Private Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function SetWindowRgn Lib "user32" (ByVal hwnd As Long, ByVal hRgn As Long, ByVal bRedraw As Long) As Long
Private Declare Function StretchBlt Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal nSrcWidth As Long, ByVal nSrcHeight As Long, ByVal dwRop As Long) As Long
Private Declare Function CreateRectRgn Lib "gdi32" (ByVal X1 As Long, ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long) As Long
Private Declare Function CombineRgn Lib "gdi32" (ByVal hDestRgn As Long, ByVal hSrcRgn1 As Long, ByVal hSrcRgn2 As Long, ByVal nCombineMode As Long) As Long
Private Declare Function CreateRoundRectRgn Lib "gdi32" (ByVal X1 As Long, ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long, ByVal X3 As Long, ByVal Y3 As Long) As Long
Private Declare Function DrawEdge Lib "user32" (ByVal hdc As Long, qrc As RECT, ByVal edge As Long, ByVal grfFlags As Long) As Long
Private Declare Function GetCursorPos Lib "user32" (lpPoint As POINTAPI) As Long
Private Declare Function ScreenToClient Lib "user32" (ByVal hwnd As Long, lpPoint As POINTAPI) As Long
Private Declare Function PlaySound Lib "winmm.dll" Alias "PlaySoundA" (ByVal lpszName As String, ByVal hModule As Long, ByVal dwFlags As Long) As Long
Private Declare Function SetCapture Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function ReleaseCapture Lib "user32" () As Long
Private Declare Function Arc Lib "gdi32" (ByVal hdc As Long, ByVal X1 As Long, ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long, ByVal X3 As Long, ByVal Y3 As Long, ByVal X4 As Long, ByVal Y4 As Long) As Long

Const m_def_CaptionAreaLayout = LayoutRight
Const m_def_CaptionLayout = CenterCenter
Const m_def_PictureLayout = CenterCenter
Const m_def_ButtonType = WindowsXPButton
Const m_def_ShowCaption = True
Const m_def_CaptionAreaPercent = 80
Const m_def_AutoMultiLine = False
Const m_def_CaptionBackColor = &HF0F0F0
Const m_def_CaptionBackColorPop = &HD1ADAD
Const m_def_CaptionBackColorPush = &HC08080
Const m_def_ShowCaptionPushColor = True
Const m_def_CaptionSmoothBackColor = &HF0F0F0
Const m_def_ShowCaptionSmooth = True
Const m_def_CaptionForeColor = vbBlack
Const m_def_CaptionMouseOverColor = vbBlack
Const m_def_CaptionMouseDownColor = vbBlack
Const m_def_CaptionMarginBottom = 2
Const m_def_CaptionMarginLeft = 2
Const m_def_CaptionMarginRight = 2
Const m_def_CaptionMarginTop = 2
Const m_def_PictureBackColor = vbButtonFace
Const m_def_PictureBackColorPop = &HD1ADAD
Const m_def_PictureBackColorPush = &HC08080
Const m_def_ShowPicturePushColor = True
Const m_def_PictureSmoothBackColor = &HDBE3EB
Const m_def_ShowPictureSmooth = True
Const m_def_PictureMarginBottom = 4
Const m_def_PictureMarginLeft = 4
Const m_def_PictureMarginRight = 4
Const m_def_PictureMarginTop = 4
Const m_def_EdgeColor = &H800000
Const m_def_ShowShadow = True
Const m_def_ShadowColor = &H9C8181
Const m_def_ShadowOffset = 2
Const m_def_RepeatDelay = 250
Const m_def_RepeatLapse = 125
Const m_def_HotKeyDynamicEffect = True
Const m_def_DynamicEffectDelay = 100
Const m_def_ShowEdgeOnNoFocus = True
Const m_def_ShowFocusRect = False
Const m_def_FoucsRectOffSet = 4
Const m_def_Hotkeys = ""
Const m_def_ShowPictureFixSize = False
Const m_def_SeperatorTbarForeColor = &HC0C0C0
Const m_def_TBHandleThick = 3
Const m_def_TbarLineBetweenSpace = 2
Const m_def_PictureFrameHeight = 26
Const m_def_PictureFrameWidth = 26
Const m_def_IgnoeDisEnabledEffect = False
Const m_def_ColorSet = ColorSets.StandardColorSet
Const m_def_PicFrameStyle = Normal
Const m_def_PicMaskColor = &HC0C0C0
Const m_def_PicFraBackColorEnabled = False
Const m_def_PicFraBackColor = &HFFFFFF
Const m_def_PicMaskColorEnabled = False
Const m_def_SoundOver = ".\media\over.wav"
Const m_def_SoundClick = ".\media\click.wav"
Const m_def_SamePic = True
'
Dim m_CaptionAreaLayout As sbAreaLayout
Dim m_CaptionLayout As sbLayout
Dim m_PictureLayout As sbLayout
Dim m_ButtonType As sbStyle
Dim m_ShowCaption As Boolean
Dim m_CaptionAreaPercent As Double
Dim m_Caption As String
Dim m_AutoMultiLine As Boolean
Dim m_CaptionBackColor As OLE_COLOR
Dim m_CaptionBackColorPop As OLE_COLOR
Dim m_CaptionBackColorPush As OLE_COLOR
Dim m_ShowCaptionPushColor As Boolean
Dim m_CaptionSmoothBackColor As OLE_COLOR
Dim m_ShowCaptionSmooth As Boolean
Dim m_CaptionForeColor As OLE_COLOR
Dim m_CaptionMouseOverColor As OLE_COLOR
Dim m_CaptionMouseDownColor As OLE_COLOR
Dim m_CaptionMarginBottom As Integer
Dim m_CaptionMarginLeft As Integer
Dim m_CaptionMarginRight As Integer
Dim m_CaptionMarginTop As Integer
Dim m_PictureBackColor As OLE_COLOR
Dim m_PictureBackColorPop As OLE_COLOR
Dim m_PictureBackColorPush As OLE_COLOR
Dim m_ShowPicturePushColor As Boolean
Dim m_PictureSmoothBackColor As OLE_COLOR
Dim m_ShowPictureSmooth As Boolean
Dim m_PictureMarginBottom As Integer
Dim m_PictureMarginLeft As Integer
Dim m_PictureMarginRight As Integer
Dim m_PictureMarginTop As Integer
Dim m_EdgeColor As OLE_COLOR
Dim m_ShowShadow As Boolean
Dim m_ShadowColor As OLE_COLOR
Dim m_PicFraBackColor As OLE_COLOR
Dim m_ShadowOffset As Integer
Dim m_RepeatDelay As Double
Dim m_RepeatLapse As Double
Dim m_HotKeyDynamicEffect As Boolean
Dim m_DynamicEffectDelay As Double
Dim m_ShowEdgeOnNoFocus As Boolean
Dim m_ShowFocusRect As Boolean
Dim m_FoucsRectOffSet As Integer
Dim m_Hotkeys As String
Dim m_ShowPictureFixSize As Boolean
Dim m_SeperatorTbarForeColor As OLE_COLOR
Dim m_TBHandleThick As Integer
Dim m_TbarLineBetweenSpace As Integer
Dim m_PictureFrameHeight As Long
Dim m_PictureFrameWidth As Long
Dim m_IgnoeDisEnabledEffect As Boolean
Dim m_ClientRect As RECT
Dim PictureAreaRect As RECT
Dim CaptionAreaRect As RECT
Dim AddinAreaRect As RECT
Dim PictureAreaAwayOffsetRect  As RECT
Dim CaptionAreaAwayOffsetRect   As RECT
Dim CaptionCalcRect As RECT
Dim PictureLayoutRect As RECT
Dim CaptionLayoutRect As RECT
Dim RightAppendAreaRect As RECT
Dim RightAppendLayoutRect  As RECT
Dim lngFormat As Long
Dim CaptionWidth As Long
Dim CaptionHeight As Long
Dim PictureWidth As Long
Dim PictureHeight As Long
Dim BeTodraw As Boolean
Dim HasPicture As Boolean
Dim HasCaption As Boolean
Dim HasSeprator As Boolean
Dim HasTBHandle As Boolean
Dim HasUp_Down As Boolean
Dim HasNextUp_down As Boolean
Dim LastKeyDown As Integer
Dim m_SoundOver As String
Dim m_SoundClick As String
Dim picNormal As StdPicture
Dim picOver As StdPicture
Dim picAddIn As StdPicture
Dim m_MouseDown As Boolean
Dim m_MouseOver As Boolean
Dim m_HasFocus As Boolean
Dim m_PicMaskColorEnabled As Boolean
Dim m_PicMaskColor As OLE_COLOR
Dim m_PicFraBackColorEnabled As Boolean
Dim m_AddinAreaWidth As Integer
Dim m_AddinAreaMargin As Integer
Dim m_AddinPicWidth As Integer
Dim m_AddinPicHeight As Integer
Dim m_ColorSet As ColorSets
Dim m_PicFrameStyle As PicFrameStyles
Dim m_SamePic As Boolean
Private He As Long, Wi As Long

Event Click()
Attribute Click.VB_UserMemId = -600
Event KeyDown(KeyCode As Integer, Shift As Integer)
Attribute KeyDown.VB_UserMemId = -602
Event KeyPress(KeyAscii As Integer)
Attribute KeyPress.VB_UserMemId = -603
Event KeyUp(KeyCode As Integer, Shift As Integer)
Attribute KeyUp.VB_UserMemId = -604
Event MouseOut()
Event MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
Attribute MouseDown.VB_UserMemId = -605
Event MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
Attribute MouseMove.VB_UserMemId = -606
Event MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
Attribute MouseUp.VB_UserMemId = -607
'
Event Resize()
Event MouseHold()
Event MouseExit()
Event DropDownClick()

Private Sub UserControl_Initialize()
    UserControl.ScaleMode = vbPixels
    UserControl.PaletteMode = vbPaletteModeContainer
End Sub

Private Sub UserControl_InitProperties()
    
    m_Caption = Ambient.DisplayName
    Set UserControl.Font = Ambient.Font
    m_ButtonType = m_def_ButtonType
    m_CaptionAreaLayout = m_def_CaptionAreaLayout
    m_CaptionAreaPercent = m_def_CaptionAreaPercent
    m_IgnoeDisEnabledEffect = m_def_IgnoeDisEnabledEffect
    m_CaptionLayout = m_def_CaptionLayout
    m_PictureLayout = m_def_PictureLayout
    m_ColorSet = m_def_ColorSet
    m_SoundOver = m_def_SoundOver
    m_SoundClick = m_def_SoundClick
    m_SamePic = m_def_SamePic
    Set picNormal = Nothing
    Set picOver = Nothing
'
    m_EdgeColor = m_def_EdgeColor
    m_ShowShadow = m_def_ShowShadow
    m_ShadowColor = m_def_ShadowColor
    m_ShadowOffset = m_def_ShadowOffset
    m_ShowEdgeOnNoFocus = m_def_ShowEdgeOnNoFocus
    m_ShowFocusRect = m_def_ShowFocusRect
    m_FoucsRectOffSet = m_def_FoucsRectOffSet
'
    m_ShowCaption = m_def_ShowCaption
    m_AutoMultiLine = m_def_AutoMultiLine
    m_CaptionMarginBottom = m_def_CaptionMarginBottom
    m_CaptionMarginLeft = m_def_CaptionMarginLeft
    m_CaptionMarginRight = m_def_CaptionMarginRight
    m_CaptionMarginTop = m_def_CaptionMarginTop
    m_CaptionBackColor = m_def_CaptionBackColor
    m_CaptionBackColorPop = m_def_CaptionBackColorPop
    m_CaptionBackColorPush = m_def_CaptionBackColorPush
    m_ShowCaptionPushColor = m_def_ShowCaptionPushColor
    m_CaptionSmoothBackColor = m_def_CaptionSmoothBackColor
    m_ShowCaptionSmooth = m_def_ShowCaptionSmooth
    m_CaptionForeColor = m_def_CaptionForeColor
    m_CaptionMouseOverColor = m_def_CaptionMouseOverColor
    m_CaptionMouseDownColor = m_def_CaptionMouseDownColor
'
    m_PicFrameStyle = m_def_PicFrameStyle
    m_PicFraBackColor = m_def_PicFraBackColor
    m_PicFraBackColorEnabled = m_def_PicFraBackColorEnabled
    m_PictureFrameHeight = m_def_PictureFrameHeight
    m_PictureFrameWidth = m_def_PictureFrameWidth
    m_ShowPictureFixSize = m_def_ShowPictureFixSize
    m_PictureMarginBottom = m_def_PictureMarginBottom
    m_PictureMarginLeft = m_def_PictureMarginLeft
    m_PictureMarginRight = m_def_PictureMarginRight
    m_PictureMarginTop = m_def_PictureMarginTop
    m_PictureBackColor = m_def_PictureBackColor
    m_PictureBackColorPop = m_def_PictureBackColorPop
    m_PictureBackColorPush = m_def_PictureBackColorPush
    m_ShowPicturePushColor = m_def_ShowPicturePushColor
    m_PictureSmoothBackColor = m_def_PictureSmoothBackColor
    m_ShowPictureSmooth = m_def_ShowPictureSmooth
'
    m_SeperatorTbarForeColor = m_def_SeperatorTbarForeColor
    m_TBHandleThick = m_def_TBHandleThick
    m_TbarLineBetweenSpace = m_def_TbarLineBetweenSpace
'
    m_Hotkeys = m_def_Hotkeys
'
End Sub

Private Sub UserControl_ReadProperties(PropBag As PropertyBag)

    With PropBag
        m_Caption = .ReadProperty("Caption", Ambient.DisplayName)
        UserControl.Enabled = PropBag.ReadProperty("Enabled", True)
        Set UserControl.Font = .ReadProperty("Font", Ambient.Font)
        Set MouseIcon = .ReadProperty("MouseIcon", Nothing)
        UserControl.MousePointer = .ReadProperty("MousePointer", 0)
        
        m_ButtonType = .ReadProperty("Button_Type", m_def_ButtonType)
        m_ColorSet = .ReadProperty("ButtonColorSet", m_def_ColorSet)
        m_CaptionAreaLayout = .ReadProperty("ButtonCaptionPosition", m_def_CaptionAreaLayout)
        m_PictureLayout = .ReadProperty("ButtonPictureLayout", m_def_PictureLayout)
        m_IgnoeDisEnabledEffect = .ReadProperty("WithoutDisEnabledEffect", m_def_IgnoeDisEnabledEffect)
        m_CaptionAreaPercent = .ReadProperty("ButtonCaptionPercent", m_def_CaptionAreaPercent)
        m_CaptionLayout = .ReadProperty("ButtonCaptionLayout", m_def_CaptionLayout)
        m_SoundOver = .ReadProperty("ButtonSound_Over", m_def_SoundOver)
        m_SoundClick = .ReadProperty("ButtonSound_Click", m_def_SoundClick)
        
        m_ShowFocusRect = .ReadProperty("SwitchFocusRect", m_def_ShowFocusRect)
        m_FoucsRectOffSet = .ReadProperty("FocusRectDis", m_def_FoucsRectOffSet)
        m_ShowEdgeOnNoFocus = .ReadProperty("SwitchBorder_Over", m_def_ShowEdgeOnNoFocus)
        m_EdgeColor = .ReadProperty("Frame_Color", m_def_EdgeColor)
        m_ShowShadow = .ReadProperty("Switch_ShowShadow", m_def_ShowShadow)
        m_ShadowColor = .ReadProperty("ShadowColor", m_def_ShadowColor)
        m_ShadowOffset = .ReadProperty("ShadowLength", m_def_ShadowOffset)
        
        m_ShowCaption = .ReadProperty("SwitchShowCaption", m_def_ShowCaption)
        m_AutoMultiLine = .ReadProperty("Caption_MultiLines", m_def_AutoMultiLine)
        m_CaptionMarginBottom = .ReadProperty("CaptionMargin_Bottom", m_def_CaptionMarginBottom)
        m_CaptionMarginLeft = .ReadProperty("CaptionMargin_Left", m_def_CaptionMarginLeft)
        m_CaptionMarginRight = .ReadProperty("CaptionMargin_Right", m_def_CaptionMarginRight)
        m_CaptionMarginTop = .ReadProperty("CaptionMargin_Top", m_def_CaptionMarginTop)
        m_CaptionBackColor = .ReadProperty("CaptionBackgroundColor", m_def_CaptionBackColor)
        m_CaptionBackColorPop = .ReadProperty("CaptionBackColor_Over", m_def_CaptionBackColorPop)
        m_CaptionBackColorPush = .ReadProperty("CaptionBackColor_Click", m_def_CaptionBackColorPush)
        m_CaptionSmoothBackColor = .ReadProperty("CaptionBackSmoothColor", m_def_CaptionSmoothBackColor)
        m_ShowCaptionPushColor = .ReadProperty("SwitchCaptionClickColor", m_def_ShowCaptionPushColor)
        m_CaptionForeColor = .ReadProperty("CaptionNormalColor", m_def_CaptionForeColor)
        m_CaptionMouseOverColor = .ReadProperty("SwitchCaptionOverColor", m_def_CaptionMouseOverColor)
        m_CaptionMouseDownColor = .ReadProperty("CaptionClickColor", m_def_CaptionMouseDownColor)
        m_ShowCaptionSmooth = .ReadProperty("SwitchCaptionSmoothColor", m_def_ShowCaptionSmooth)
        
        Set picNormal = .ReadProperty("ButtonPicture_Normal", Nothing)
        Set picOver = .ReadProperty("ButtonPicture_Over", Nothing)
        Set picAddIn = .ReadProperty("ButtonPicture_Addin", Nothing)
        m_ShowPictureFixSize = .ReadProperty("SwitchScalePicture", m_def_ShowPictureFixSize)
        m_PictureFrameHeight = .ReadProperty("PictureFrame_Height", m_def_PictureFrameHeight)
        m_PictureFrameWidth = .ReadProperty("PictureFrame_Width", m_def_PictureFrameWidth)
        m_PictureMarginBottom = .ReadProperty("PictureFrameMargin_Bottom", m_def_PictureMarginBottom)
        m_PictureMarginLeft = .ReadProperty("PictureFrameMargin_Left", m_def_PictureMarginLeft)
        m_PictureMarginRight = .ReadProperty("PictureFrameMargin_Right", m_def_PictureMarginRight)
        m_PictureMarginTop = .ReadProperty("PictureFrameMargin_Top", m_def_PictureMarginTop)
        m_PicMaskColorEnabled = .ReadProperty("SwitchPictureForeColor", m_def_PicMaskColorEnabled)
        m_PicMaskColor = .ReadProperty("PictureForeColor", m_def_PicMaskColor)
        m_PicFraBackColorEnabled = .ReadProperty("SwitchPictureFrameBackColor", m_def_PicFraBackColorEnabled)
        m_PicFraBackColor = .ReadProperty("PictureFrameBackColor", m_def_PicFraBackColor)
        m_PictureBackColor = .ReadProperty("PictureAreaBackColor", m_def_PictureBackColor)
        m_PictureBackColorPop = .ReadProperty("PictureFrameBackColor_Over", m_def_PictureBackColorPop)
        m_PictureBackColorPush = .ReadProperty("PictureAreaBackColor_Click", m_def_PictureBackColorPush)
        m_ShowPicturePushColor = .ReadProperty("SwitchPictureFrameBackColor_Click", m_def_ShowPicturePushColor)
        m_PictureSmoothBackColor = .ReadProperty("PictureAreaBackSmoothColor", m_def_PictureSmoothBackColor)
        m_ShowPictureSmooth = .ReadProperty("SwitchPictureFrameBackSmoothColor", m_def_ShowPictureSmooth)
        
        
        m_SeperatorTbarForeColor = .ReadProperty("ToolBarForeColor", m_def_SeperatorTbarForeColor)
        m_TBHandleThick = .ReadProperty("ToolBarHandle_Width", m_def_TBHandleThick)
        m_TbarLineBetweenSpace = .ReadProperty("ToolBarHandle_LineSpace", m_def_TbarLineBetweenSpace)
        
        m_AddinPicWidth = .ReadProperty("PictureAddin_Width", 0)
        m_AddinPicHeight = .ReadProperty("PictureAddin_Height", 0)
        m_AddinAreaMargin = .ReadProperty("PictureAddin_Margin", 0)
        m_AddinAreaWidth = m_AddinPicWidth + 2 * m_AddinAreaMargin
        
        m_Hotkeys = .ReadProperty("HotKey", m_def_Hotkeys)
        
        m_PicFrameStyle = .ReadProperty("PictureFrameEffect", m_def_PicFrameStyle)

    End With

    If Not picOver Is Nothing Then
        m_SamePic = False
    ElseIf Not picNormal Is Nothing Then
        m_SamePic = True
        Set picOver = picNormal
    End If
    
    SetHotKeys

End Sub

Private Sub UserControl_WriteProperties(PropBag As PropertyBag)

    With PropBag
        Call .WriteProperty("Caption", m_Caption, Ambient.DisplayName)
        Call .WriteProperty("Enabled", UserControl.Enabled, True)
        Call .WriteProperty("Font", UserControl.Font, Ambient.Font)
        Call .WriteProperty("MouseIcon", MouseIcon, Nothing)
        Call .WriteProperty("MousePointer", UserControl.MousePointer, 0)
    
        Call .WriteProperty("Button_Type", m_ButtonType, m_def_ButtonType)
        Call .WriteProperty("ButtonColorSet", m_ColorSet, m_def_ColorSet)
        Call .WriteProperty("ButtonCaptionPercent", m_CaptionAreaPercent, m_def_CaptionAreaPercent)
        Call .WriteProperty("ButtonCaptionPosition", m_CaptionAreaLayout, m_def_CaptionAreaLayout)
        Call .WriteProperty("ButtonCaptionLayout", m_CaptionLayout, m_def_CaptionLayout)
        Call .WriteProperty("ButtonPictureLayout", m_PictureLayout, m_def_PictureLayout)
        Call .WriteProperty("ButtonPicture_Normal", picNormal, Nothing)
        Call .WriteProperty("ButtonPicture_Over", picOver, Nothing)
        Call .WriteProperty("ButtonPicture_Addin", picAddIn, Nothing)
        Call .WriteProperty("ButtonSound_Over", m_SoundOver, m_def_SoundOver)
        Call .WriteProperty("ButtonSound_Click", m_SoundClick, m_def_SoundClick)
        Call .WriteProperty("WithoutDisEnabledEffect", m_IgnoeDisEnabledEffect, m_def_IgnoeDisEnabledEffect)
    
        Call .WriteProperty("Frame_Color", m_EdgeColor, m_def_EdgeColor)
        Call .WriteProperty("Switch_ShowShadow", m_ShowShadow, m_def_ShowShadow)
        Call .WriteProperty("ShadowColor", m_ShadowColor, m_def_ShadowColor)
        Call .WriteProperty("ShadowLength", m_ShadowOffset, m_def_ShadowOffset)
        Call .WriteProperty("SwitchBorder_Over", m_ShowEdgeOnNoFocus, m_def_ShowEdgeOnNoFocus)
        Call .WriteProperty("SwitchFocusRect", m_ShowFocusRect, m_def_ShowFocusRect)
        Call .WriteProperty("FocusRectDis", m_FoucsRectOffSet, m_def_FoucsRectOffSet)
    
        Call .WriteProperty("SwitchShowCaption", m_ShowCaption, m_def_ShowCaption)
        Call .WriteProperty("Caption_MultiLines", m_AutoMultiLine, m_def_AutoMultiLine)
        Call .WriteProperty("CaptionBackgroundColor", m_CaptionBackColor, m_def_CaptionBackColor)
        Call .WriteProperty("CaptionBackColor_Over", m_CaptionBackColorPop, m_def_CaptionBackColorPop)
        Call .WriteProperty("CaptionBackColor_Click", m_CaptionBackColorPush, m_def_CaptionBackColorPush)
        Call .WriteProperty("SwitchCaptionClickColor", m_ShowCaptionPushColor, m_def_ShowCaptionPushColor)
        Call .WriteProperty("CaptionBackSmoothColor", m_CaptionSmoothBackColor, m_def_CaptionSmoothBackColor)
        Call .WriteProperty("SwitchCaptionSmoothColor", m_ShowCaptionSmooth, m_def_ShowCaptionSmooth)
        Call .WriteProperty("CaptionNormalColor", m_CaptionForeColor, m_def_CaptionForeColor)
        Call .WriteProperty("SwitchCaptionOverColor", m_CaptionMouseOverColor, m_def_CaptionMouseOverColor)
        Call .WriteProperty("CaptionClickColor", m_CaptionMouseDownColor, m_def_CaptionMouseDownColor)
        Call .WriteProperty("CaptionMargin_Bottom", m_CaptionMarginBottom, m_def_CaptionMarginBottom)
        Call .WriteProperty("CaptionMargin_Left", m_CaptionMarginLeft, m_def_CaptionMarginLeft)
        Call .WriteProperty("CaptionMargin_Right", m_CaptionMarginRight, m_def_CaptionMarginRight)
        Call .WriteProperty("CaptionMargin_Top", m_CaptionMarginTop, m_def_CaptionMarginTop)
    
        Call .WriteProperty("PictureFrameBackColor", m_PicFraBackColor, m_def_PicFraBackColor)
        Call .WriteProperty("SwitchPictureFrameBackColor", m_PicFraBackColorEnabled, m_def_PicFraBackColorEnabled)
        Call .WriteProperty("PictureForeColor", m_PicMaskColor, m_def_PicMaskColor)
        Call .WriteProperty("SwitchPictureForeColor", m_PicMaskColorEnabled, m_def_PicMaskColorEnabled)
        Call .WriteProperty("PictureAreaBackColor", m_PictureBackColor, m_def_PictureBackColor)
        Call .WriteProperty("PictureFrameBackColor_Over", m_PictureBackColorPop, m_def_PictureBackColorPop)
        Call .WriteProperty("PictureAreaBackColor_Click", m_PictureBackColorPush, m_def_PictureBackColorPush)
        Call .WriteProperty("SwitchPictureFrameBackColor_Click", m_ShowPicturePushColor, m_def_ShowPicturePushColor)
        Call .WriteProperty("PictureAreaBackSmoothColor", m_PictureSmoothBackColor, m_def_PictureSmoothBackColor)
        Call .WriteProperty("SwitchPictureFrameBackSmoothColor", m_ShowPictureSmooth, m_def_ShowPictureSmooth)
        Call .WriteProperty("PictureFrameMargin_Bottom", m_PictureMarginBottom, m_def_PictureMarginBottom)
        Call .WriteProperty("PictureFrameMargin_Left", m_PictureMarginLeft, m_def_PictureMarginLeft)
        Call .WriteProperty("PictureFrameMargin_Right", m_PictureMarginRight, m_def_PictureMarginRight)
        Call .WriteProperty("PictureFrameMargin_Top", m_PictureMarginTop, m_def_PictureMarginTop)
        Call .WriteProperty("SwitchScalePicture", m_ShowPictureFixSize, m_def_ShowPictureFixSize)
        Call .WriteProperty("PictureFrame_Height", m_PictureFrameHeight, m_def_PictureFrameHeight)
        Call .WriteProperty("PictureFrame_Width", m_PictureFrameWidth, m_def_PictureFrameWidth)
    
        Call .WriteProperty("ToolBarForeColor", m_SeperatorTbarForeColor, m_def_SeperatorTbarForeColor)
        Call .WriteProperty("ToolBarHandle_Width", m_TBHandleThick, m_def_TBHandleThick)
        Call .WriteProperty("ToolBarHandle_LineSpace", m_TbarLineBetweenSpace, m_def_TbarLineBetweenSpace)
    
        Call .WriteProperty("PictureAddin_Margin", m_AddinAreaMargin, 0)
        Call .WriteProperty("PictureAddin_Width", m_AddinPicWidth, 0)
        Call .WriteProperty("PictureAddin_Height", m_AddinPicHeight, 0)
    
        Call .WriteProperty("HotKey", m_Hotkeys, m_def_Hotkeys)
    
        Call .WriteProperty("PictureFrameEffect", m_PicFrameStyle, m_def_PicFrameStyle)
    
    End With

End Sub
Public Property Get Button_Type() As sbStyle
    Button_Type = m_ButtonType
End Property
Public Property Let Button_Type(ByVal New_ButtonType As sbStyle)
    Dim TmpSaveStyle As sbStyle
    
    TmpSaveStyle = m_ButtonType
    m_ButtonType = New_ButtonType
    
    Select Case m_ButtonType
    Case OfficeXPSeparator
        Enabled = False
        PropertyChanged "Enabled"
        PropertyChanged "Button_Type"
    Case OfficeXPHandle
        If m_ButtonType = OfficeXPHandle Then
            MousePointer = vbSizeAll
            PropertyChanged "MousePointer"
        End If
        PropertyChanged "Button_Type"
    Case HintsUp_DownArrow
        m_AddinPicWidth = 8
        m_AddinPicHeight = 14
        m_AddinAreaMargin = 4
        m_AddinAreaWidth = m_AddinPicWidth + 2 * m_AddinAreaMargin
        PropertyChanged "PictureAddin_Width"
        PropertyChanged "PictureAddin_Height"
        PropertyChanged "PictureAddin_Margin"
        If BeTodraw Then
            If m_ButtonType = OfficeXPHandle Then
                MousePointer = vbSizeAll
                PropertyChanged "MousePointer"
            End If
            PropertyChanged "Button_Type"
        Else
            m_ButtonType = TmpSaveStyle
            PropertyChanged "Button_Type"
        End If
    Case WindowsXPButton, OfficeXPButton
        PropertyChanged "Button_Type"
        If MousePointer <> vbDefault Then
            MousePointer = vbDefault
            PropertyChanged "MousePointer"
        End If
    Case OfficeXPButtonPro
        m_AddinPicWidth = 8
        m_AddinPicHeight = 15
        m_AddinAreaMargin = 4
        m_AddinAreaWidth = m_AddinPicWidth + 2 * m_AddinAreaMargin
        PropertyChanged "PictureAddin_Width"
        PropertyChanged "PictureAddin_Height"
        PropertyChanged "PictureAddin_Margin"
        PropertyChanged "Button_Type"
        If MousePointer <> vbDefault Then
            MousePointer = vbDefault
            PropertyChanged "MousePointer"
        End If
    Case IEButton
        m_AddinPicWidth = 6
        m_AddinPicHeight = 3
        m_AddinAreaMargin = 4
        m_AddinAreaWidth = m_AddinPicWidth + 2 * m_AddinAreaMargin
        PropertyChanged "PictureAddin_Width"
        PropertyChanged "PictureAddin_Height"
        PropertyChanged "PictureAddin_Margin"
        PropertyChanged "Button_Type"
        If MousePointer <> vbDefault Then
            MousePointer = vbDefault
            PropertyChanged "MousePointer"
        End If
    End Select
    Refresh

End Property
Public Property Get ButtonCaptionPercent() As Double
    ButtonCaptionPercent = m_CaptionAreaPercent
End Property
Public Property Let ButtonCaptionPercent(ByVal New_CaptionAreaPercent As Double)
    Dim TmpButtonCaptionPercent As Double
    TmpButtonCaptionPercent = m_CaptionAreaPercent
    If New_CaptionAreaPercent > 100 Or New_CaptionAreaPercent < 0 Then
        m_CaptionAreaPercent = TmpButtonCaptionPercent
        PropertyChanged "ButtonCaptionPercent"
        MsgBox "ButtonCaptionPercent should be 0 to 100", vbOKOnly
    Else
        m_CaptionAreaPercent = New_CaptionAreaPercent
        PropertyChanged "ButtonCaptionPercent"
        Refresh
    End If
End Property
Public Property Get ButtonCaptionLayout() As sbLayout
    ButtonCaptionLayout = m_CaptionLayout
End Property
Public Property Let ButtonCaptionLayout(ByVal New_CaptionLayout As sbLayout)
    m_CaptionLayout = New_CaptionLayout
    PropertyChanged "ButtonCaptionLayout"
    Refresh
End Property
Public Property Get ButtonCaptionPosition() As sbAreaLayout
    ButtonCaptionPosition = m_CaptionAreaLayout
End Property
Public Property Let ButtonCaptionPosition(ByVal New_CaptionAreaLayout As sbAreaLayout)
    m_CaptionAreaLayout = New_CaptionAreaLayout
    PropertyChanged "ButtonCaptionPosition"
    Refresh
End Property
Public Property Get ButtonColorSet() As ColorSets
    ButtonColorSet = m_ColorSet
End Property
Public Property Let ButtonColorSet(ByVal New_ButtonColorSet As ColorSets)
    Dim tmpButtonColorSet  As ColorSets
    m_ColorSet = New_ButtonColorSet
    PropertyChanged "ButtonColorSet"
    Select Case m_ColorSet
    Case StandardColorSet
        m_EdgeColor = m_def_EdgeColor
        PropertyChanged "Frame_Color"
        m_ShowShadow = m_def_ShowShadow
        PropertyChanged "Switch_ShowShadow"
        m_ShadowColor = m_def_ShadowColor
        PropertyChanged "ShadowColor"
        m_ShadowOffset = m_def_ShadowOffset
        PropertyChanged "ShadowLength"
        m_ShowEdgeOnNoFocus = m_def_ShowEdgeOnNoFocus
        PropertyChanged "SwitchBorder_Over"
        m_ShowFocusRect = m_def_ShowFocusRect
        PropertyChanged "SwitchFocusRect"
        m_FoucsRectOffSet = m_def_FoucsRectOffSet
        PropertyChanged "FocusRectDis"
        
        m_CaptionBackColor = m_def_CaptionBackColor
        PropertyChanged "CaptionBackgroundColor"
        m_CaptionBackColorPop = m_def_CaptionBackColorPop
        PropertyChanged "CaptionBackColor_Over"
        m_CaptionBackColorPush = m_def_CaptionBackColorPush
        PropertyChanged "CaptionBackColor_Click"
        m_ShowCaptionPushColor = m_def_ShowCaptionPushColor
        PropertyChanged "SwitchCaptionClickColor"
        m_CaptionSmoothBackColor = m_def_CaptionSmoothBackColor
        PropertyChanged "CaptionBackSmoothColor"
        m_ShowCaptionSmooth = m_def_ShowCaptionSmooth
        PropertyChanged "SwitchCaptionSmoothColor"
        m_CaptionForeColor = m_def_CaptionForeColor
        PropertyChanged "CaptionNormalColor"
        m_CaptionMouseOverColor = m_def_CaptionMouseOverColor
        PropertyChanged "SwitchCaptionOverColor"
        m_CaptionMouseDownColor = m_def_CaptionMouseDownColor
        PropertyChanged "CaptionClickColor"
        
        m_PicFraBackColor = m_def_PicFraBackColor
        PropertyChanged "PictureFrameBackColor"
        m_PicFraBackColorEnabled = m_def_PicFraBackColorEnabled
        PropertyChanged "SwitchPictureFrameBackColor"
        m_PictureBackColor = m_def_PictureBackColor
        PropertyChanged "PictureAreaBackColor"
        m_PictureBackColorPop = m_def_PictureBackColorPop
        PropertyChanged "PictureFrameBackColor_Over"
        m_PictureBackColorPush = m_def_PictureBackColorPush
        PropertyChanged "PictureAreaBackColor_Click"
        m_ShowPicturePushColor = m_def_ShowPicturePushColor
        PropertyChanged "SwitchPictureFrameBackColor_Click"
        m_PictureSmoothBackColor = m_def_PictureSmoothBackColor
        PropertyChanged "PictureAreaBackSmoothColor"
        m_ShowPictureSmooth = m_def_ShowPictureSmooth
        PropertyChanged "SwitchPictureFrameBackSmoothColor"
        m_PicMaskColorEnabled = m_def_PicMaskColorEnabled
        PropertyChanged "SwitchPictureForeColor"
        m_PicMaskColor = m_def_PicMaskColor
        PropertyChanged "PictureForeColor"
        m_SeperatorTbarForeColor = m_def_SeperatorTbarForeColor
        PropertyChanged "ToolBarForeColor"
        m_PicFrameStyle = m_def_PicFrameStyle
        PropertyChanged "PictureFrameEffect"
    
        ReDraw True
    Case CustomColorSet
        Select Case m_ButtonType
        Case WindowsXPButton
            MsgBox "WindowsXPButton Do Not Support CustomColorSet", vbInformation
        End Select
    End Select
End Property
Public Property Get ButtonSound_Over() As Variant
    ButtonSound_Over = m_SoundOver
End Property
Public Property Let ButtonSound_Over(ByVal New_SoundOver As Variant)
    m_SoundOver = New_SoundOver
    PropertyChanged "ButtonSound_Over"
End Property
Public Property Get ButtonSound_Click() As String
    ButtonSound_Click = m_SoundClick
End Property
Public Property Let ButtonSound_Click(ByVal New_SoundClick As String)
    m_SoundClick = New_SoundClick
    PropertyChanged "ButtonSound_Click"
End Property
Public Property Get ButtonPicture_Normal() As StdPicture
    Set ButtonPicture_Normal = picNormal
End Property
Public Property Set ButtonPicture_Normal(ByVal newPic As StdPicture)
    Set picNormal = newPic
    PropertyChanged "ButtonPicture_Normal"
    If Not picNormal Is Nothing Then
        If m_ShowPictureFixSize = False Then
            m_PictureFrameWidth = UserControl.ScaleX(picNormal.Width, vbHimetric, vbPixels) _
                                   + m_PictureMarginLeft + m_PictureMarginRight
            PropertyChanged "PictureFrame_Width"
            m_PictureFrameHeight = UserControl.ScaleX(picNormal.Height, vbHimetric, vbPixels) _
                                   + m_PictureMarginTop + m_PictureMarginBottom
            PropertyChanged "PictureFrame_Height"
        End If
    End If
    Refresh
End Property
Public Property Get ButtonPicture_Addin() As StdPicture
    Set ButtonPicture_Addin = picAddIn
End Property
Public Property Set ButtonPicture_Addin(ByVal newPic As StdPicture)
    Set picAddIn = newPic
    PropertyChanged "ButtonPicture_Addin"
    If Not picAddIn Is Nothing Then
        Select Case m_ButtonType
        Case OfficeXPButtonPro, IEButton, WindowsXPButton, OfficeXPButton
            m_AddinPicWidth = UserControl.ScaleX(picAddIn.Width, vbHimetric, vbPixels)
            PropertyChanged "PictureAddin_Width"
            m_AddinPicHeight = UserControl.ScaleX(picAddIn.Height, vbHimetric, vbPixels)
            PropertyChanged "PictureAddin_Height"
            If m_AddinAreaMargin = 0 Then
                m_AddinAreaMargin = 4
                PropertyChanged "PictureAddin_Margin"
            End If
            m_AddinAreaWidth = m_AddinPicWidth + 2 * m_AddinAreaMargin
        End Select
    Else
        Select Case m_ButtonType
        Case WindowsXPButton, OfficeXPButton
            m_AddinPicWidth = 0
            m_AddinPicHeight = 0
            m_AddinAreaMargin = 0
            m_AddinAreaWidth = 0
            PropertyChanged "PictureAddin_Width"
            PropertyChanged "PictureAddin_Height"
            PropertyChanged "PictureAddin_Margin"
        Case HintsUp_DownArrow
            m_AddinPicWidth = 8
            m_AddinPicHeight = 14
            m_AddinAreaMargin = 4
            m_AddinAreaWidth = m_AddinPicWidth + 2 * m_AddinAreaMargin
            PropertyChanged "PictureAddin_Width"
            PropertyChanged "PictureAddin_Height"
            PropertyChanged "PictureAddin_Margin"
        Case OfficeXPButtonPro
            m_AddinPicWidth = 8
            m_AddinPicHeight = 15
            m_AddinAreaMargin = 4
            m_AddinAreaWidth = m_AddinPicWidth + 2 * m_AddinAreaMargin
            PropertyChanged "PictureAddin_Width"
            PropertyChanged "PictureAddin_Height"
            PropertyChanged "PictureAddin_Margin"
        Case IEButton
            m_AddinPicWidth = 6
            m_AddinPicHeight = 3
            m_AddinAreaMargin = 4
            m_AddinAreaWidth = m_AddinPicWidth + 2 * m_AddinAreaMargin
            PropertyChanged "PictureAddin_Width"
            PropertyChanged "PictureAddin_Height"
            PropertyChanged "PictureAddin_Margin"
        End Select
    End If
    Refresh
End Property
Public Property Get ButtonPicture_Over() As StdPicture
    Set ButtonPicture_Over = picOver
End Property
Public Property Set ButtonPicture_Over(ByVal newPic As StdPicture)
    Set picOver = newPic
    PropertyChanged "ButtonPicture_Over"
End Property
Public Property Get ButtonPictureLayout() As sbLayout
    ButtonPictureLayout = m_PictureLayout
End Property
Public Property Let ButtonPictureLayout(ByVal New_PictureLayout As sbLayout)
    m_PictureLayout = New_PictureLayout
    PropertyChanged "ButtonPictureLayout"
    Refresh
End Property
Public Property Get Caption() As String
    Caption = m_Caption
End Property
Public Property Let Caption(ByVal New_Caption As String)
    m_Caption = New_Caption
    PropertyChanged "Caption"
    Refresh
End Property
Public Property Let Enabled(ByVal New_Enabled As Boolean)
    If New_Enabled <> UserControl.Enabled() Then
        UserControl.Enabled() = New_Enabled
        
        ReDraw True
        PropertyChanged "Enabled"
    End If
End Property
Public Property Get Enabled() As Boolean
    Enabled = UserControl.Enabled
End Property
Public Property Get Font() As Font
    Set Font = UserControl.Font
End Property
Public Property Set Font(ByVal New_Font As Font)
    Set UserControl.Font = New_Font
    ReDraw True
    PropertyChanged "Font"
End Property
Public Property Get FontUnderline() As Boolean
    FontUnderline = UserControl.FontUnderline
End Property
Public Property Let FontUnderline(ByVal New_FontUnderline As Boolean)
    UserControl.FontUnderline() = New_FontUnderline
    ReDraw True
    PropertyChanged "Font"
End Property
Public Property Get FontStrikethru() As Boolean
    FontStrikethru = UserControl.FontStrikethru
End Property
Public Property Let FontStrikethru(ByVal New_FontStrikethru As Boolean)
    UserControl.FontStrikethru() = New_FontStrikethru
    ReDraw True
    PropertyChanged "Font"
End Property
Public Property Get FontSize() As Single
    FontSize = UserControl.FontSize
End Property
Public Property Let FontSize(ByVal New_FontSize As Single)
    UserControl.FontSize() = New_FontSize
    ReDraw True
    PropertyChanged "Font"
End Property
Public Property Get FontName() As String
    FontName = UserControl.FontName
End Property
Public Property Let FontName(ByVal New_FontName As String)
    UserControl.FontName() = New_FontName
    ReDraw True
    PropertyChanged "Font"
End Property
Public Property Get FontItalic() As Boolean
    FontItalic = UserControl.FontItalic
End Property
Public Property Let FontItalic(ByVal New_FontItalic As Boolean)
    UserControl.FontItalic() = New_FontItalic
    ReDraw True
    PropertyChanged "Font"
End Property
Public Property Get FontBold() As Boolean
    FontBold = UserControl.FontBold
End Property
Public Property Let FontBold(ByVal New_FontBold As Boolean)
    UserControl.FontBold() = New_FontBold
    ReDraw True
    PropertyChanged "Font"
End Property
Public Property Get hdc() As Long
    hdc = UserControl.hdc
End Property
Public Property Get hwnd() As Long
    hwnd = UserControl.hwnd
End Property
Public Property Get MouseIcon() As StdPicture
    Set MouseIcon = UserControl.MouseIcon
End Property
Public Property Set MouseIcon(ByVal New_MouseIcon As StdPicture)
    Set UserControl.MouseIcon = New_MouseIcon
    PropertyChanged "MouseIcon"
End Property
Public Property Get MousePointer() As MousePointerConstants
    MousePointer = UserControl.MousePointer
End Property
Public Property Let MousePointer(ByVal New_MousePointer As MousePointerConstants)
    UserControl.MousePointer() = New_MousePointer
    PropertyChanged "MousePointer"
End Property
Public Property Get CaptionBackgroundColor() As OLE_COLOR
    CaptionBackgroundColor = m_CaptionBackColor
    Dim TmpRGBColor As Long
    TmpRGBColor = BreakApart(m_CaptionBackColor)
    TmpRGBColor = SmoothColor(TmpRGBColor)
    m_CaptionSmoothBackColor = TmpRGBColor
    PropertyChanged "CaptionBackSmoothColor"
End Property
Public Property Let CaptionBackgroundColor(ByVal New_CaptionBackColor As OLE_COLOR)
    m_CaptionBackColor = New_CaptionBackColor
    PropertyChanged "CaptionBackgroundColor"
    Dim TmpRGBColor As Long
    TmpRGBColor = BreakApart(m_CaptionBackColor)
    TmpRGBColor = SmoothColor(TmpRGBColor)
    m_CaptionSmoothBackColor = TmpRGBColor
    PropertyChanged "CaptionBackSmoothColor"
    ReDraw
End Property
Public Property Get CaptionBackColor_Click() As OLE_COLOR
    CaptionBackColor_Click = m_CaptionBackColorPush
End Property
Public Property Let CaptionBackColor_Click(ByVal New_CaptionBackColorPush As OLE_COLOR)
    m_CaptionBackColorPush = New_CaptionBackColorPush
    PropertyChanged "CaptionBackColor_Click"
End Property
Public Property Get CaptionBackSmoothColor() As OLE_COLOR
    CaptionBackSmoothColor = m_CaptionSmoothBackColor
End Property
Public Property Let CaptionBackSmoothColor(ByVal New_CaptionSmoothBackColor As OLE_COLOR)
    Dim TmpRGBColor As Long
    TmpRGBColor = BreakApart(m_CaptionBackColor)
    TmpRGBColor = SmoothColor(TmpRGBColor)
    m_CaptionSmoothBackColor = TmpRGBColor
    PropertyChanged "CaptionBackSmoothColor"
    ReDraw
End Property
Public Property Get CaptionBackColor_Over() As OLE_COLOR
    CaptionBackColor_Over = m_CaptionBackColorPop
End Property
Public Property Let CaptionBackColor_Over(ByVal New_CaptionBackColorPop As OLE_COLOR)
    m_CaptionBackColorPop = New_CaptionBackColorPop
    PropertyChanged "CaptionBackColor_Over"
End Property
Public Property Get CaptionMargin_Bottom() As Integer
    CaptionMargin_Bottom = m_CaptionMarginBottom
End Property
Public Property Let CaptionMargin_Bottom(ByVal New_CaptionMarginBottom As Integer)
    m_CaptionMarginBottom = New_CaptionMarginBottom
    PropertyChanged "CaptionMarginBottom"
    Refresh
End Property
Public Property Get CaptionMargin_Top() As Integer
    CaptionMargin_Top = m_CaptionMarginTop
End Property
Public Property Let CaptionMargin_Top(ByVal New_CaptionMarginTop As Integer)
    m_CaptionMarginTop = New_CaptionMarginTop
    PropertyChanged "CaptionMarginTop"
    Refresh
End Property
Public Property Get CaptionMargin_Left() As Integer
    CaptionMargin_Left = m_CaptionMarginLeft
End Property
Public Property Let CaptionMargin_Left(ByVal New_CaptionMarginLeft As Integer)
    m_CaptionMarginLeft = New_CaptionMarginLeft
    PropertyChanged "CaptionMarginLeft"
    Refresh
End Property
Public Property Get CaptionMargin_Right() As Integer
    CaptionMargin_Right = m_CaptionMarginRight
End Property
Public Property Let CaptionMargin_Right(ByVal New_CaptionMarginRight As Integer)
    m_CaptionMarginRight = New_CaptionMarginRight
    PropertyChanged "CaptionMarginRight"
    Refresh
End Property
Public Property Get CaptionNormalColor() As OLE_COLOR
    CaptionNormalColor = m_CaptionForeColor
End Property
Public Property Let CaptionNormalColor(ByVal New_CaptionForeColor As OLE_COLOR)
    m_CaptionForeColor = New_CaptionForeColor
    PropertyChanged "CaptionNormalColor"
    ReDraw
End Property
Public Property Get CaptionClickColor() As OLE_COLOR
    CaptionClickColor = m_CaptionMouseDownColor
End Property
Public Property Let CaptionClickColor(ByVal New_CaptionMouseDownColor As OLE_COLOR)
    m_CaptionMouseDownColor = New_CaptionMouseDownColor
    PropertyChanged "CaptionClickColor"
End Property
Public Property Get SwitchCaptionOverColor() As OLE_COLOR
    SwitchCaptionOverColor = m_CaptionMouseOverColor
End Property
Public Property Let SwitchCaptionOverColor(ByVal New_CaptionMouseOverColor As OLE_COLOR)
    m_CaptionMouseOverColor = New_CaptionMouseOverColor
    PropertyChanged "SwitchCaptionOverColor"
End Property
Public Property Get SwitchCaptionClickColor() As Boolean
    SwitchCaptionClickColor = m_ShowCaptionPushColor
End Property
Public Property Let SwitchCaptionClickColor(ByVal New_ShowCaptionPushColor As Boolean)
    If CBool(New_ShowCaptionPushColor) Then New_ShowCaptionPushColor = True Else New_ShowCaptionPushColor = False
    m_ShowCaptionPushColor = New_ShowCaptionPushColor
    PropertyChanged "SwitchCaptionClickColor"
End Property
Public Property Get SwitchCaptionSmoothColor() As Boolean
    SwitchCaptionSmoothColor = m_ShowCaptionSmooth
End Property
Public Property Let SwitchCaptionSmoothColor(ByVal New_ShowCaptionSmooth As Boolean)
    If CBool(New_ShowCaptionSmooth) Then New_ShowCaptionSmooth = True Else New_ShowCaptionSmooth = False
    m_ShowCaptionSmooth = New_ShowCaptionSmooth
    PropertyChanged "SwitchCaptionSmoothColor"
    ReDraw
End Property
Public Property Get Caption_MultiLines() As Boolean
    Caption_MultiLines = m_AutoMultiLine
End Property
Public Property Let Caption_MultiLines(ByVal New_AutoMultiLine As Boolean)
    If CBool(New_AutoMultiLine) Then New_AutoMultiLine = True Else New_AutoMultiLine = False
    m_AutoMultiLine = New_AutoMultiLine
    PropertyChanged "Caption_MultiLines"
    Refresh
End Property
Public Property Get SwitchShowCaption() As Boolean
    SwitchShowCaption = m_ShowCaption
End Property
Public Property Let SwitchShowCaption(ByVal New_ShowCaption As Boolean)
    If CBool(New_ShowCaption) Then New_ShowCaption = True Else New_ShowCaption = False
    m_ShowCaption = New_ShowCaption
    PropertyChanged "SwitchShowCaption"
    Refresh
End Property
Public Property Get Frame_Color() As OLE_COLOR
    Frame_Color = m_EdgeColor
End Property
Public Property Let Frame_Color(ByVal New_EdgeColor As OLE_COLOR)
    m_EdgeColor = New_EdgeColor
    PropertyChanged "Frame_Color"
    ReDraw
End Property
Public Property Get SwitchBorder_Over() As Boolean
    SwitchBorder_Over = m_ShowEdgeOnNoFocus
End Property
Public Property Let SwitchBorder_Over(ByVal New_ShowEdgeOnNoFocus As Boolean)
    If CBool(New_ShowEdgeOnNoFocus) Then New_ShowEdgeOnNoFocus = True Else New_ShowEdgeOnNoFocus = False
    m_ShowEdgeOnNoFocus = New_ShowEdgeOnNoFocus
    PropertyChanged "SwitchBorder_Over"
End Property
Public Property Get WithoutDisEnabledEffect() As Boolean
    WithoutDisEnabledEffect = m_IgnoeDisEnabledEffect
End Property
Public Property Let WithoutDisEnabledEffect(ByVal New_IgnoeDisEnabledEffect As Boolean)
    Dim TmpSave As Boolean
    TmpSave = m_IgnoeDisEnabledEffect
    If CBool(New_IgnoeDisEnabledEffect) Then New_IgnoeDisEnabledEffect = True Else New_IgnoeDisEnabledEffect = False
    m_IgnoeDisEnabledEffect = New_IgnoeDisEnabledEffect
    Select Case m_ButtonType
    Case WindowsXPButton, OfficeXPButton, OfficeXPButtonPro, IEButton
        PropertyChanged "WithoutDisEnabledEffect"
        ReDraw
    Case Else
        m_IgnoeDisEnabledEffect = TmpSave
        PropertyChanged "WithoutDisEnabledEffect"
        ReDraw
    End Select
End Property
Public Property Get PictureAddin_Margin() As Integer
    PictureAddin_Margin = m_AddinAreaMargin
End Property
Public Property Let PictureAddin_Margin(ByVal New_AddinAreaMargin As Integer)
    Dim tmpPictureAddin_Margin  As Integer
    tmpPictureAddin_Margin = m_AddinAreaMargin
    m_AddinAreaMargin = New_AddinAreaMargin
    Select Case m_ButtonType
    Case OfficeXPHandle, OfficeXPHandle
        m_AddinAreaMargin = tmpPictureAddin_Margin
        PropertyChanged "PictureAddin_Margin"
    Case OfficeXPButtonPro, IEButton, HintsUp_DownArrow, WindowsXPButton, OfficeXPButton
        PropertyChanged "PictureAddin_Margin"
        m_AddinAreaWidth = m_AddinPicWidth + 2 * m_AddinAreaMargin
        Refresh
    End Select
End Property
Public Property Get PictureAddin_Width() As Integer
    PictureAddin_Width = m_AddinPicWidth
End Property
Public Property Let PictureAddin_Width(ByVal New_AddinPicWidth As Integer)
    Dim tmpPictureAddin_Width  As Integer
    tmpPictureAddin_Width = m_AddinPicWidth
    m_AddinPicWidth = New_AddinPicWidth
    Select Case m_ButtonType
    Case OfficeXPHandle, OfficeXPHandle
        m_AddinPicWidth = tmpPictureAddin_Width
        PropertyChanged "PictureAddin_Width"
    Case OfficeXPButtonPro, IEButton, HintsUp_DownArrow, WindowsXPButton, OfficeXPButton
        PropertyChanged "PictureAddin_Width"
        m_AddinAreaWidth = m_AddinPicWidth + 2 * m_AddinAreaMargin
        Refresh
    End Select
End Property
Public Property Get PictureAddin_Height() As Integer
    PictureAddin_Height = m_AddinPicHeight
End Property
Public Property Let PictureAddin_Height(ByVal New_AddinPicHeight As Integer)
    Dim tmpPictureAddin_Height  As Integer
    tmpPictureAddin_Height = m_AddinPicHeight
    m_AddinPicHeight = New_AddinPicHeight
    Select Case m_ButtonType
    Case OfficeXPHandle, OfficeXPHandle
        m_AddinPicHeight = tmpPictureAddin_Height
        PropertyChanged "PictureAddin_Height"
    Case OfficeXPButtonPro, IEButton, HintsUp_DownArrow, WindowsXPButton, OfficeXPButton
        PropertyChanged "PictureAddin_Height"
        Refresh
    End Select
End Property
Public Property Get ToolBarHandle_LineSpace() As Integer
    ToolBarHandle_LineSpace = m_TbarLineBetweenSpace
End Property
Public Property Let ToolBarHandle_LineSpace(ByVal New_TbarLineBetweenSpace As Integer)
    Dim TmpSave As Integer
    TmpSave = m_TbarLineBetweenSpace
    m_TbarLineBetweenSpace = New_TbarLineBetweenSpace
    Select Case m_ButtonType
    Case OfficeXPHandle
        PropertyChanged "ToolBarHandle_LineSpace"
        Refresh
    Case Else
        m_TbarLineBetweenSpace = TmpSave
        PropertyChanged "ToolBarHandle_LineSpace"
    End Select
End Property
Public Property Get ToolBarHandle_Width() As Integer
    ToolBarHandle_Width = m_TBHandleThick
End Property
Public Property Let ToolBarHandle_Width(ByVal New_TBHandleThick As Integer)
    Dim TmpSave As Integer
    TmpSave = m_TBHandleThick
    m_TBHandleThick = New_TBHandleThick
    Select Case m_ButtonType
    Case OfficeXPHandle
        PropertyChanged "ToolBarHandle_Width"
        Refresh
    Case Else
        m_TBHandleThick = TmpSave
        PropertyChanged "ToolBarHandle_Width"
    End Select
End Property
Public Property Get ToolBarForeColor() As OLE_COLOR
    ToolBarForeColor = m_SeperatorTbarForeColor
End Property
Public Property Let ToolBarForeColor(ByVal New_SeperatorTbarForeColor As OLE_COLOR)
    Dim TmpSave As Long
    TmpSave = m_SeperatorTbarForeColor
    m_SeperatorTbarForeColor = New_SeperatorTbarForeColor
    Select Case m_ButtonType
    Case OfficeXPSeparator, OfficeXPHandle
        PropertyChanged "ToolBarForeColor"
        ReDraw
    Case Else
        m_SeperatorTbarForeColor = TmpSave
        PropertyChanged "ToolBarForeColor"
    End Select
End Property
Public Property Get FocusRectDis() As Integer
    FocusRectDis = m_FoucsRectOffSet
End Property
Public Property Let FocusRectDis(ByVal New_FoucsRectOffSet As Integer)
    m_FoucsRectOffSet = New_FoucsRectOffSet
    PropertyChanged "FocusRectDis"
End Property
Public Property Get SwitchFocusRect() As Boolean
    SwitchFocusRect = m_ShowFocusRect
End Property
Public Property Let SwitchFocusRect(ByVal New_ShowFocusRect As Boolean)
    If CBool(New_ShowFocusRect) Then New_ShowFocusRect = True Else New_ShowFocusRect = False
    m_ShowFocusRect = New_ShowFocusRect
    PropertyChanged "SwitchFocusRect"
End Property
Public Property Get HotKey() As String
    HotKey = m_Hotkeys
End Property
Public Property Let HotKey(ByVal New_Hotkeys As String)
    m_Hotkeys = New_Hotkeys
    PropertyChanged "HotKey"
End Property
Public Property Get SwitchPictureForeColor() As Boolean
    SwitchPictureForeColor = m_PicMaskColorEnabled
End Property
Public Property Let SwitchPictureForeColor(ByVal NewValue As Boolean)
    m_PicMaskColorEnabled = NewValue
    PropertyChanged "SwitchPictureForeColor"
    ReDraw
End Property
Public Property Get PictureForeColor() As OLE_COLOR
    PictureForeColor = m_PicMaskColor
End Property
Public Property Let PictureForeColor(ByVal New_PicMaskColor As OLE_COLOR)
    m_PicMaskColor = New_PicMaskColor
    PropertyChanged "PictureForeColor"
    ReDraw
End Property
Public Property Get SwitchScalePicture() As Boolean
    SwitchScalePicture = m_ShowPictureFixSize
End Property
Public Property Let SwitchScalePicture(ByVal New_ShowPictureFixSize As Boolean)
    If CBool(New_ShowPictureFixSize) Then New_ShowPictureFixSize = True Else New_ShowPictureFixSize = False
    m_ShowPictureFixSize = New_ShowPictureFixSize
    PropertyChanged "SwitchScalePicture"
    Refresh
End Property
Public Property Get PictureAreaBackColor() As OLE_COLOR
    PictureAreaBackColor = m_PictureBackColor
    Dim TmpRGBColor As Long
    TmpRGBColor = BreakApart(m_PictureBackColor)
    TmpRGBColor = SmoothColor(TmpRGBColor)
    m_PictureSmoothBackColor = TmpRGBColor
    PropertyChanged "PictureAreaBackSmoothColor"
End Property
Public Property Let PictureAreaBackColor(ByVal New_PictureBackColor As OLE_COLOR)
    m_PictureBackColor = New_PictureBackColor
    PropertyChanged "PictureAreaBackColor"
    Dim TmpRGBColor As Long
    TmpRGBColor = BreakApart(m_PictureBackColor)
    TmpRGBColor = SmoothColor(TmpRGBColor)
    m_PictureSmoothBackColor = TmpRGBColor
    PropertyChanged "PictureAreaBackSmoothColor"
    ReDraw
End Property
Public Property Get PictureAreaBackColor_Click() As OLE_COLOR
    PictureAreaBackColor_Click = m_PictureBackColorPush
End Property
Public Property Let PictureAreaBackColor_Click(ByVal New_PictureBackColorPush As OLE_COLOR)
    m_PictureBackColorPush = New_PictureBackColorPush
    PropertyChanged "PictureAreaBackColor_Click"
End Property
Public Property Get PictureAreaBackSmoothColor() As OLE_COLOR
    PictureAreaBackSmoothColor = m_PictureSmoothBackColor
End Property
Public Property Let PictureAreaBackSmoothColor(ByVal New_PictureSmoothBackColor As OLE_COLOR)
    Dim TmpRGBColor As Long
    TmpRGBColor = BreakApart(m_PictureBackColor)
    TmpRGBColor = SmoothColor(TmpRGBColor)
    m_PictureSmoothBackColor = TmpRGBColor
    PropertyChanged "PictureAreaBackSmoothColor"
    ReDraw
End Property
Public Property Get PictureFrameBackColor_Over() As OLE_COLOR
    PictureFrameBackColor_Over = m_PictureBackColorPop
End Property
Public Property Let PictureFrameBackColor_Over(ByVal New_PictureBackColorPop As OLE_COLOR)
    m_PictureBackColorPop = New_PictureBackColorPop
    PropertyChanged "PictureFrameBackColor_Over"
End Property
Public Property Get SwitchPictureFrameBackColor_Click() As Boolean
    SwitchPictureFrameBackColor_Click = m_ShowPicturePushColor
End Property
Public Property Let SwitchPictureFrameBackColor_Click(ByVal New_ShowPicturePushColor As Boolean)
    If CBool(New_ShowPicturePushColor) Then New_ShowPicturePushColor = True Else New_ShowPicturePushColor = False
    m_ShowPicturePushColor = New_ShowPicturePushColor
    PropertyChanged "SwitchPictureFrameBackColor_Click"
End Property
Public Property Get SwitchPictureFrameBackSmoothColor() As Boolean
    SwitchPictureFrameBackSmoothColor = m_ShowPictureSmooth
End Property
Public Property Let SwitchPictureFrameBackSmoothColor(ByVal New_ShowPictureSmooth As Boolean)
    If CBool(New_ShowPictureSmooth) Then New_ShowPictureSmooth = True Else New_ShowPictureSmooth = False
    m_ShowPictureSmooth = New_ShowPictureSmooth
    PropertyChanged "SwitchPictureFrameBackSmoothColor"
    ReDraw
End Property
Public Property Get PictureFrameBackColor() As OLE_COLOR
    PictureFrameBackColor = m_PicFraBackColor
End Property
Public Property Let PictureFrameBackColor(ByVal New_PicFraBackColor As OLE_COLOR)
    m_PicFraBackColor = New_PicFraBackColor
    PropertyChanged "PictureFrameBackColor"
    ReDraw
End Property
Public Property Get SwitchPictureFrameBackColor() As Boolean
    SwitchPictureFrameBackColor = m_PicFraBackColorEnabled
End Property
Public Property Let SwitchPictureFrameBackColor(ByVal NewValue As Boolean)
    Dim tmpSwitchPictureFrameBackColor  As Boolean
    tmpSwitchPictureFrameBackColor = m_PicFraBackColorEnabled
    m_PicFraBackColorEnabled = NewValue
    Select Case m_ButtonType
    Case OfficeXPHandle, OfficeXPHandle, HintsUp_DownArrow
        m_PicFrameStyle = tmpSwitchPictureFrameBackColor
        PropertyChanged "SwitchPictureFrameBackColor"
    Case WindowsXPButton, OfficeXPButton, OfficeXPButtonPro, IEButton
        PropertyChanged "SwitchPictureFrameBackColor"
        ReDraw
    End Select
End Property
Public Property Get PictureFrame_Height() As Long
    PictureFrame_Height = m_PictureFrameHeight
End Property
Public Property Let PictureFrame_Height(ByVal New_PictureFrameHeight As Long)
    Dim tmpPictureFrame_Height As Long
    tmpPictureFrame_Height = m_PictureFrameHeight
    m_PictureFrameHeight = New_PictureFrameHeight
    If m_ShowPictureFixSize = True Then
        PropertyChanged "PictureFrame_Height"
        Refresh
    Else
        m_PictureFrameHeight = tmpPictureFrame_Height
        PropertyChanged "PictureFrame_Height"
    End If
End Property
Public Property Get PictureFrame_Width() As Long
    PictureFrame_Width = m_PictureFrameWidth
End Property
Public Property Let PictureFrame_Width(ByVal New_PictureFrameWidth As Long)
    Dim tmpPictureFrame_Width As Long
    tmpPictureFrame_Width = m_PictureFrameWidth
    m_PictureFrameWidth = New_PictureFrameWidth
    If m_ShowPictureFixSize = True Then
        PropertyChanged "PictureFrame_Width"
        Refresh
    Else
        m_PictureFrameWidth = tmpPictureFrame_Width
        PropertyChanged "PictureFrame_Width"
    End If
End Property
Public Property Get PictureFrameMargin_Bottom() As Integer
    PictureFrameMargin_Bottom = m_PictureMarginBottom
End Property
Public Property Let PictureFrameMargin_Bottom(ByVal New_PictureMarginBottom As Integer)
    m_PictureMarginBottom = New_PictureMarginBottom
    PropertyChanged "PictureFrameMargin_Bottom"
    Refresh
End Property
Public Property Get PictureFrameMargin_Top() As Integer
    PictureFrameMargin_Top = m_PictureMarginTop
End Property
Public Property Let PictureFrameMargin_Top(ByVal New_PictureMarginTop As Integer)
    m_PictureMarginTop = New_PictureMarginTop
    PropertyChanged "PictureFrameMargin_Top"
    Refresh
End Property
Public Property Get PictureFrameMargin_Left() As Integer
    PictureFrameMargin_Left = m_PictureMarginLeft
End Property
Public Property Let PictureFrameMargin_Left(ByVal New_PictureMarginLeft As Integer)
    m_PictureMarginLeft = New_PictureMarginLeft
    PropertyChanged "PictureFrameMargin_Left"
    Refresh
End Property
Public Property Get PictureFrameMargin_Right() As Integer
    PictureFrameMargin_Right = m_PictureMarginRight
End Property
Public Property Let PictureFrameMargin_Right(ByVal New_PictureMarginRight As Integer)
    m_PictureMarginRight = New_PictureMarginRight
    PropertyChanged "PictureFrameMargin_Right"
    Refresh
End Property
Public Property Get PictureFrameEffect() As PicFrameStyles
    PictureFrameEffect = m_PicFrameStyle
End Property
Public Property Let PictureFrameEffect(ByVal NewValue As PicFrameStyles)
    Dim tmpPictureFrameEffect  As PicFrameStyles
    tmpPictureFrameEffect = m_PicFrameStyle
    m_PicFrameStyle = NewValue
    Select Case m_ButtonType
    Case OfficeXPHandle, OfficeXPHandle, HintsUp_DownArrow
        m_PicFrameStyle = tmpPictureFrameEffect
        PropertyChanged "PictureFrameEffect"
    Case WindowsXPButton, OfficeXPButton, OfficeXPButtonPro, IEButton
        PropertyChanged "PictureFrameEffect"
        ReDraw
    End Select
End Property
Public Property Get ShadowLength() As Integer
    ShadowLength = m_ShadowOffset
End Property
Public Property Let ShadowLength(ByVal New_ShadowOffset As Integer)
    m_ShadowOffset = New_ShadowOffset
    PropertyChanged "ShadowLength"
End Property
Public Property Get ShadowColor() As OLE_COLOR
    ShadowColor = m_ShadowColor
End Property
Public Property Let ShadowColor(ByVal New_ShadowColor As OLE_COLOR)
    m_ShadowColor = New_ShadowColor
    PropertyChanged "ShadowColor"
End Property
Public Property Get Switch_ShowShadow() As Boolean
    Switch_ShowShadow = m_ShowShadow
End Property
Public Property Let Switch_ShowShadow(ByVal New_ShowShadow As Boolean)
    If CBool(New_ShowShadow) Then New_ShowShadow = True Else New_ShowShadow = False
    m_ShowShadow = New_ShowShadow
    PropertyChanged "Switch_ShowShadow"
End Property

Private Sub UserControl_AccessKeyPress(KeyAscii As Integer)
    RaiseEvent KeyPress(KeyAscii)
    If vbKeySpace Or KeyAscii = vbKeyEscape Or KeyAscii = vbKeyReturn Then
        UserControl_Click 'Default / Cancel
        Exit Sub
    End If

    If InStr(UCase(UserControl.AccessKeys), UCase(Chr(KeyAscii))) > 0 Then UserControl_Click
End Sub

Private Sub UserControl_Click()
    RaiseEvent Click
    m_MouseDown = False
    m_MouseOver = True
    m_HasFocus = True
    PlayASound m_SoundClick
    ReDraw True
End Sub

Private Sub UserControl_DblClick()
    m_MouseDown = True
    ReDraw True
End Sub

Private Sub UserControl_GotFocus()
    m_HasFocus = True
    If picNormal Is Nothing Then CalcAllRect
    ReDraw
End Sub

Private Sub UserControl_KeyDown(KeyCode As Integer, Shift As Integer)
    RaiseEvent KeyDown(KeyCode, Shift)
    LastKeyDown = KeyCode
    If KeyCode = vbKeySpace Then
        m_MouseOver = True
        If Not m_MouseDown Then
            m_MouseDown = True
            ReDraw True
        End If
    ElseIf (KeyCode = vbKeyRight) Or (KeyCode = vbKeyDown) Then
        SendKeys "{Tab}"
        ReDraw
    ElseIf (KeyCode = vbKeyLeft) Or (KeyCode = vbKeyUp) Then
        SendKeys "+{Tab}"
        ReDraw
    End If
End Sub

Private Sub UserControl_KeyPress(KeyAscii As Integer)
    RaiseEvent KeyPress(KeyAscii)
    If KeyAscii = vbKeyReturn Then
        UserControl_Click
        Exit Sub
    End If
    If InStr(UCase(UserControl.AccessKeys), UCase(Chr(KeyAscii))) > 0 Then UserControl_Click
End Sub

Private Sub UserControl_KeyUp(KeyCode As Integer, Shift As Integer)
    RaiseEvent KeyUp(KeyCode, Shift)
    If (KeyCode = vbKeySpace) And (LastKeyDown = vbKeySpace) Then
        UserControl_Click
    End If
End Sub

Private Sub UserControl_LostFocus()
    m_HasFocus = False
    m_MouseOver = False
    m_MouseDown = False
    ReDraw
End Sub

Private Sub UserControl_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    RaiseEvent MouseDown(Button, Shift, X, Y)
    If Button = vbLeftButton Then
        m_MouseDown = True
        m_MouseOver = True
        ReDraw
    End If
End Sub
    
Private Sub UserControl_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    
    RaiseEvent MouseMove(Button, Shift, X, Y)
    SetCapture hwnd
    If PointInControl(X, Y) Then
        If Not m_MouseOver Then
            m_MouseOver = True
            m_MouseDown = False
            Select Case m_ButtonType
            Case WindowsXPButton
                If picNormal Is Nothing Then CalcAllRect
                ReDraw
            Case OfficeXPButton, OfficeXPButtonPro, IEButton
                If picNormal Is Nothing Then CalcAllRect
                If Not m_HasFocus Then ReDraw
            End Select
            PlayASound m_SoundOver
            RaiseEvent MouseMove(Button, Shift, X, Y)
        End If
    Else
        m_MouseOver = False
        Select Case m_ButtonType
        Case WindowsXPButton
            If m_MouseDown Then
                m_MouseDown = False
                If picNormal Is Nothing Then CalcAllRect
                ReDraw True
            Else
                If picNormal Is Nothing Then CalcAllRect
                ReDraw
            End If
        Case OfficeXPButton, OfficeXPButtonPro, IEButton
            If Not m_HasFocus Then
                If picNormal Is Nothing Then CalcAllRect
                ReDraw
            End If
        End Select
        RaiseEvent MouseOut
        ReleaseCapture
    End If
End Sub

Private Sub UserControl_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
    
    If Button = vbLeftButton Then
        If m_ButtonType = IEButton And X > PictureAreaRect.Right Then
            RaiseEvent DropDownClick
        Else
            RaiseEvent MouseUp(Button, Shift, X, Y)
        End If
    End If

End Sub

Private Sub UserControl_Paint()
    Me.Refresh
End Sub

Public Sub Refresh()
    CalcAllRect
    ReDraw True
End Sub

Private Sub UserControl_Resize()
    Call SetRect(m_ClientRect, 0, 0, UserControl.ScaleWidth - 1, UserControl.ScaleHeight - 1)
    He = UserControl.ScaleHeight
    Wi = UserControl.ScaleWidth
    Refresh
End Sub

Private Sub UserControl_Terminate()
    Set picNormal = Nothing
    Set picOver = Nothing
    Set picAddIn = Nothing
End Sub

Private Sub SetHotKeys()
    Dim iPos As Integer, sChar As String, i As Integer
    For i = 1 To Len(m_Hotkeys)
        sChar = UCase(Mid$(m_Hotkeys, i, 1))
        iPos = InStr(1, UserControl.AccessKeys, sChar)
        If iPos <= 0 Then
            If sChar <> "&" Then
                UserControl.AccessKeys = UserControl.AccessKeys & sChar
            End If
        End If
    Next i
End Sub

Private Function PointInControl(X As Single, Y As Single) As Boolean
  If X >= 0 And X <= UserControl.ScaleWidth And _
    Y >= 0 And Y <= UserControl.ScaleHeight Then
    PointInControl = True
  End If
End Function

Public Sub ReDraw(Optional ByVal Force As Boolean = False)
    
    If He = 0 Then Exit Sub
    Rect_Paint UserControl.hdc, Force
    Call RoundCorners
    Select Case m_CaptionAreaLayout
    Case CaptionOverPicture
        PictureArea_Paint UserControl.hdc, Force
        Caption_Paint UserControl.hdc, Force
    Case Else
        Caption_Paint UserControl.hdc, Force
        PictureArea_Paint UserControl.hdc, Force
    End Select

End Sub

Private Sub RoundCorners()
Dim TempRect As Long, TempRect1 As Long, TempRect2 As Long
    
    TempRect = CreateRectRgn(0, 0, Wi, He)
    Select Case m_ButtonType
    Case WindowsXPButton
        TempRect1 = CreateRoundRectRgn(0, -1, Wi + 1, He + 1, 8, 8)
        TempRect2 = CreateRectRgn(0, 0, Wi + 1, He + 1)
        CombineRgn TempRect, TempRect2, TempRect1, 1
        SetWindowRgn UserControl.hwnd, TempRect, True
        DeleteObject TempRect1
        DeleteObject TempRect2
    Case Else
        SetWindowRgn UserControl.hwnd, TempRect, True
    End Select
    DeleteObject TempRect

End Sub

Private Function Rect_Paint(DstDC As Long, Optional ByVal Force As Boolean = False) As Boolean

    Dim stepXP As Single, XPFace As Long, XPFace2 As Long, loop1 As Integer
    Dim TmpRGBColor1 As Long, TmpRect As RECT, hRPen As Long, TmpCount As Long, TmpPoint As POINTAPI
    Dim CoorRight As Long
    
    Select Case m_ButtonType
    Case WindowsXPButton
        
        XPFace = ShiftColor(&HFFFFFF, &H30, True)
        
        stepXP = 25 / He
                
        If m_MouseDown Then
            XPFace = ShiftColor(&HC0C0C0, &H30, True)
            XPFace2 = ShiftColor(XPFace, -32, True)
            stepXP = 25 / He
            For loop1 = 0 To He
                DrawLine 0, loop1, Wi, loop1, ShiftColor(XPFace2, -stepXP * loop1, True)
            Next
                    
            DrawLine 1, 1, Wi - 2, 1, ShiftColor(XPFace2, -&H20, True)
            DrawLine 1, 2, Wi - 2, 2, ShiftColor(XPFace2, -&H18, True)
            DrawLine 1, 2, 1, He - 2, ShiftColor(XPFace2, -&H20, True)
            DrawLine 2, 3, 2, He - 3, ShiftColor(XPFace2, -&H16, True)
            DrawLine Wi - 2, 2, Wi - 2, He - 2, ShiftColor(XPFace2, &H5, True)
            DrawLine Wi - 3, 3, Wi - 3, He - 3, XPFace
            DrawLine 1, He - 2, Wi - 2, He - 2, ShiftColor(XPFace2, &H10, True)
            DrawLine 1, He - 3, Wi - 2, He - 3, ShiftColor(XPFace2, &HA, True)
            
            DrawBorder DstDC, Wi, He, &H733C00
        
        ElseIf m_MouseOver Then
            If Force Then
                For loop1 = 1 To He - 1
                    DrawLine 0, loop1, Wi, loop1, ShiftColor(XPFace, -stepXP * loop1, True)
                Next
            Else
                If Not m_HasFocus Then
                    CoorRight = IIf(PictureAreaRect.Right = 0 Or m_SamePic, 3, PictureAreaRect.Right)
                    For loop1 = 3 To He - 4
                        DrawLine 1, loop1, CoorRight, loop1, ShiftColor(XPFace, -stepXP * loop1, True)
                    Next
                End If
            End If
            
            DrawLine 1, 1, Wi - 2, 1, &HCEF3FF
            DrawLine 1, 2, Wi - 2, 2, &H8CDBFF
            DrawLine 1, 2, 1, He - 2, &H31B2FF
            DrawLine 2, 4, 2, He - 3, &H6BCBFF
            DrawLine Wi - 2, 1, Wi - 2, He - 1, &H31B2FF
            DrawLine Wi - 3, 4, Wi - 3, He - 3, &H6BCBFF
            DrawLine 1, He - 3, Wi - 2, He - 3, &H31B2FF
            DrawLine 1, He - 2, Wi - 2, He - 2, &H96E7&
        
            DrawBorder DstDC, Wi, He, &H733C00
        
        ElseIf Enabled Or m_IgnoeDisEnabledEffect Then
            
            If Force Then
                For loop1 = 1 To He - 1
                    DrawLine 0, loop1, Wi, loop1, ShiftColor(XPFace, -stepXP * loop1, True)
                Next
            Else
                CoorRight = IIf(PictureAreaRect.Right = 0 Or m_SamePic, 3, PictureAreaRect.Right)
                If Not m_HasFocus Then
                    For loop1 = 1 To 2
                        DrawLine 0, loop1, Wi, loop1, ShiftColor(XPFace, -stepXP * loop1, True)
                    Next
                    For loop1 = 3 To He - 4
                        DrawLine 1, loop1, CoorRight, loop1, ShiftColor(XPFace, -stepXP * loop1, True)
                        DrawLine Wi - 3, loop1, Wi, loop1, ShiftColor(XPFace, -stepXP * loop1, True)
                    Next
                    For loop1 = He - 3 To He - 2
                        DrawLine 0, loop1, Wi, loop1, ShiftColor(XPFace, -stepXP * loop1, True)
                    Next
                End If
            End If
            
            If m_HasFocus Then
                DrawLine 1, 1, Wi - 2, 1, &HFFE7CE
                DrawLine 1, 2, Wi - 2, 2, &HF7D7BD
                DrawLine 1, 2, 1, He - 2, &HE7AE8C
                DrawLine 2, 3, 2, He - 3, &HF0D1B5
                DrawLine Wi - 2, 2, Wi - 2, He - 2, &HE7AE8C
                DrawLine Wi - 3, 3, Wi - 3, He - 3, &HF0D1B5
                DrawLine 1, He - 3, Wi - 2, He - 3, &HF0D1B5
                DrawLine 1, He - 2, Wi - 2, He - 2, &HEF826B
            End If
        
            DrawBorder DstDC, Wi, He, &H733C00
        
        Else
            XPFace2 = ShiftColor(XPFace, -&H18, True)
            For loop1 = 0 To He
                DrawLine 0, loop1, Wi, loop1, ShiftColor(XPFace2, -stepXP * loop1, True)
            Next
            XPFace2 = ShiftColor(XPFace, -&H54, True)
            
            DrawBorder DstDC, Wi, He, XPFace2
        End If
    
    Case OfficeXPButton, OfficeXPButtonPro, HintsUp_DownArrow
        If m_MouseDown And m_ButtonType = OfficeXPButton Then
            If HasPicture Then
                TmpRGBColor1 = BreakApart(m_PictureBackColorPush)
                DrawRectangle DstDC, 0, 0, PictureAreaRect.Right, He, TmpRGBColor1
            End If
                
            If PictureAreaRect.Right < Wi - 1 Then
                TmpRGBColor1 = BreakApart(m_CaptionBackColorPush)
                DrawRectangle DstDC, PictureAreaRect.Right, 0, Wi - PictureAreaRect.Right, He, TmpRGBColor1
            End If
                
            TmpRGBColor1 = BreakApart(m_EdgeColor)
            DrawRectangle DstDC, 0, 0, Wi, He, TmpRGBColor1, True
            
            If m_ShowFocusRect Then
                Call SetRect(TmpRect, m_FoucsRectOffSet, m_FoucsRectOffSet, Wi - m_FoucsRectOffSet, He - m_FoucsRectOffSet)
                Call DrawFocusRect(DstDC, TmpRect)
            End If
        
        ElseIf m_MouseOver Or m_HasFocus Then
            If HasPicture Then
                TmpRGBColor1 = BreakApart(m_PictureBackColorPop)
                DrawRectangle DstDC, 0, 0, PictureAreaRect.Right, He, TmpRGBColor1
            End If
                
            If PictureAreaRect.Right < Wi - 1 Then
                TmpRGBColor1 = BreakApart(m_CaptionBackColorPop)
                DrawRectangle DstDC, PictureAreaRect.Right, 0, Wi - PictureAreaRect.Right, He, TmpRGBColor1
            End If
                
            TmpRGBColor1 = BreakApart(m_EdgeColor)
            DrawRectangle DstDC, 0, 0, Wi, He, TmpRGBColor1, True
            
            If m_ShowFocusRect Then
                Call SetRect(TmpRect, m_FoucsRectOffSet, m_FoucsRectOffSet, Wi - m_FoucsRectOffSet, He - m_FoucsRectOffSet)
                Call DrawFocusRect(DstDC, TmpRect)
            End If
        Else
            If HasPicture Then
                If m_ShowPictureSmooth Then
                    TmpRGBColor1 = BreakApart(m_PictureSmoothBackColor)
                Else
                    TmpRGBColor1 = BreakApart(m_PictureBackColor)
                End If
                DrawRectangle DstDC, 0, 0, PictureAreaRect.Right, He, TmpRGBColor1
            End If
                
            If PictureAreaRect.Right < Wi - 1 Then
                If m_ShowCaptionSmooth Then
                    TmpRGBColor1 = BreakApart(m_CaptionSmoothBackColor)
                Else
                    TmpRGBColor1 = BreakApart(m_CaptionBackColor)
                End If
                DrawRectangle DstDC, PictureAreaRect.Right, 0, Wi - PictureAreaRect.Right, He, TmpRGBColor1
            End If
        End If
        
        Select Case m_ButtonType
        Case OfficeXPButtonPro
            If picAddIn Is Nothing Then Call DrawUp_DownArrow(&H0&)
        Case HintsUp_DownArrow
            Call DrawNextUp_DownArrow(&H0&)
        End Select
    
    Case IEButton
        
        TmpRGBColor1 = BreakApart(&H8000000F)
        DrawRectangle DstDC, 0, 0, Wi, He, TmpRGBColor1
        
        If m_MouseDown Then
            TmpRect.Left = 0
            TmpRect.Right = Wi
            TmpRect.Top = 0
            TmpRect.Bottom = He
            DrawEdge DstDC, TmpRect, BDR_SUNKENINNER, BF_RECT
            
            If HasCaption Then
                TmpRGBColor1 = BreakApart(m_CaptionMouseDownColor)
                SetTextColor DstDC, TmpRGBColor1
                DrawText UserControl.hdc, m_Caption, -1, CaptionLayoutRect, lngFormat
            End If
        
        ElseIf m_MouseOver Or m_HasFocus Then
            TmpRect.Left = 0
            TmpRect.Right = Wi
            TmpRect.Top = 0
            TmpRect.Bottom = He
            DrawEdge DstDC, TmpRect, BDR_RAISEDINNER, BF_RECT
        End If
    
        If picAddIn Is Nothing Then Call DrawUp_DownArrow(&H0&)
    
    Case OfficeXPSeparator
        If m_ShowPictureSmooth Then
            TmpRGBColor1 = BreakApart(m_PictureSmoothBackColor)
        Else
            TmpRGBColor1 = BreakApart(m_PictureBackColor)
        End If
        DrawRectangle DstDC, 0, 0, Wi, He, TmpRGBColor1
        
        TmpRGBColor1 = BreakApart(m_SeperatorTbarForeColor)
        hRPen = CreatePen(PS_SOLID, 1, TmpRGBColor1)
        SelectObject DstDC, hRPen
        With PictureLayoutRect
            TmpPoint.X = .Left
            TmpPoint.Y = .Top
            MoveToEx DstDC, .Left, .Top, TmpPoint
            LineTo DstDC, .Left, .Bottom
        End With
        DeleteObject hRPen

    Case OfficeXPHandle
        If m_ShowPictureSmooth Then
            TmpRGBColor1 = BreakApart(m_PictureSmoothBackColor)
        Else
            TmpRGBColor1 = BreakApart(m_PictureBackColor)
        End If
        DrawRectangle DstDC, 0, 0, Wi, He, TmpRGBColor1
    
        TmpRGBColor1 = BreakApart(m_SeperatorTbarForeColor)
        hRPen = CreatePen(PS_SOLID, 1, TmpRGBColor1)
        SelectObject DstDC, hRPen
        With PictureLayoutRect
            For TmpCount = .Top To .Bottom
                Select Case TmpCount Mod m_TbarLineBetweenSpace
                Case 0
                    TmpPoint.X = .Left
                    TmpPoint.Y = TmpCount
                    MoveToEx DstDC, .Left, TmpCount, TmpPoint
                    LineTo DstDC, .Right, TmpCount
                End Select
            Next TmpCount
        End With
        DeleteObject hRPen
    
    End Select

End Function

Private Function Caption_Paint(DstDC As Long, Optional ByVal Force As Boolean = False) As Boolean

    Dim TmpRGBColor1 As Long
    
    Select Case m_ButtonType
    Case WindowsXPButton
        If m_MouseDown Then
            If HasCaption Then
                TmpRGBColor1 = BreakApart(m_CaptionMouseDownColor)
                SetTextColor DstDC, TmpRGBColor1
                DrawText UserControl.hdc, m_Caption, -1, CaptionLayoutRect, lngFormat
            End If
        ElseIf m_MouseOver Then
            If HasCaption Then
                TmpRGBColor1 = BreakApart(m_CaptionMouseOverColor)
                SetTextColor DstDC, TmpRGBColor1
                DrawText UserControl.hdc, m_Caption, -1, CaptionLayoutRect, lngFormat
            End If
        ElseIf Enabled Or m_IgnoeDisEnabledEffect Then
            If HasCaption Then
                TmpRGBColor1 = BreakApart(m_CaptionForeColor)
                SetTextColor DstDC, TmpRGBColor1
                DrawText UserControl.hdc, m_Caption, -1, CaptionLayoutRect, lngFormat
            End If
        Else
            If HasCaption Then
                TmpRGBColor1 = BreakApart(m_ShadowColor)
                SetTextColor DstDC, TmpRGBColor1
                DrawText UserControl.hdc, m_Caption, -1, CaptionLayoutRect, lngFormat
            End If
        End If
    
    Case OfficeXPButton, OfficeXPButtonPro
        If m_MouseDown Then
            If HasCaption Then
                TmpRGBColor1 = BreakApart(m_CaptionMouseDownColor)
                SetTextColor DstDC, TmpRGBColor1
                DrawText UserControl.hdc, m_Caption, -1, CaptionLayoutRect, lngFormat
            End If
        ElseIf m_MouseOver Or m_HasFocus Then
            If HasCaption Then
                If Not m_IgnoeDisEnabledEffect Then
                    If Enabled Then
                        TmpRGBColor1 = BreakApart(m_CaptionMouseOverColor)
                    Else
                        TmpRGBColor1 = BreakApart(m_ShadowColor)
                    End If
                Else
                    TmpRGBColor1 = BreakApart(m_CaptionMouseOverColor)
                End If
                SetTextColor DstDC, TmpRGBColor1
                DrawText UserControl.hdc, m_Caption, -1, CaptionLayoutRect, lngFormat
            End If
        ElseIf HasCaption Then
            If Enabled Or m_IgnoeDisEnabledEffect Then
                TmpRGBColor1 = BreakApart(m_CaptionForeColor)
            Else
                TmpRGBColor1 = BreakApart(m_ShadowColor)
            End If
            SetTextColor DstDC, TmpRGBColor1
            DrawText UserControl.hdc, m_Caption, -1, CaptionLayoutRect, lngFormat
        End If
        
    Case IEButton
        If m_MouseDown Then
            If HasCaption Then
                TmpRGBColor1 = BreakApart(m_CaptionMouseDownColor)
                SetTextColor DstDC, TmpRGBColor1
                DrawText UserControl.hdc, m_Caption, -1, CaptionLayoutRect, lngFormat
            End If
        ElseIf m_MouseOver Or m_HasFocus Then
            If HasCaption Then
                If Not m_IgnoeDisEnabledEffect Then
                    If Enabled Then
                        TmpRGBColor1 = BreakApart(m_CaptionMouseOverColor)
                    Else
                        TmpRGBColor1 = BreakApart(m_ShadowColor)
                    End If
                Else
                    TmpRGBColor1 = BreakApart(m_CaptionMouseOverColor)
                End If
                SetTextColor DstDC, TmpRGBColor1
                DrawText UserControl.hdc, m_Caption, -1, CaptionLayoutRect, lngFormat
            End If
        ElseIf HasCaption Then
            If Enabled Or m_IgnoeDisEnabledEffect Then
                TmpRGBColor1 = BreakApart(m_CaptionForeColor)
            Else
                TmpRGBColor1 = BreakApart(m_ShadowColor)
            End If
            SetTextColor DstDC, TmpRGBColor1
            DrawText UserControl.hdc, m_Caption, -1, CaptionLayoutRect, lngFormat
        End If
    End Select

End Function

Private Sub DrawBorder(DstDC As Long, ByVal Width As Long, ByVal Height As Long, ByVal Color As Long)
    Dim oldPen As Long, hPen As Long
    
    DrawRectangle DstDC, 0, 0, Wi, He, Color, True
    
    hPen = CreatePen(PS_SOLID, 1, Color)
    oldPen = SelectObject(DstDC, hPen)
    Arc DstDC, 0, 0, 8, 8, 4, 0, 0, 4
    Arc DstDC, Wi - 8, 0, Wi, 8, Wi, 4, Wi - 4, 0
    Arc DstDC, 0, He - 8, 8, He, 0, He - 4, 4, He
    Arc DstDC, Wi - 8, He - 8, Wi, He, Wi - 4, He, Wi, He - 4
    SelectObject DstDC, oldPen
    DeleteObject hPen

End Sub

Private Sub DrawLine(ByVal X1 As Long, ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long, ByVal Color As Long)
    Dim pt As POINTAPI
    Dim oldPen As Long, hPen As Long

    With UserControl
        hPen = CreatePen(PS_SOLID, 1, Color)
        oldPen = SelectObject(.hdc, hPen)
    
        MoveToEx .hdc, X1, Y1, pt
        LineTo .hdc, X2, Y2
    
        SelectObject .hdc, oldPen
        DeleteObject hPen
    End With

End Sub

Private Sub DrawRectangle(DstDC As Long, ByVal X As Long, ByVal Y As Long, ByVal Width As Long, ByVal Height As Long, ByVal Color As Long, Optional OnlyBorder As Boolean = False)

    Dim bRECT As RECT
    Dim hBrush As Long

    bRECT.Left = X
    bRECT.Top = Y
    bRECT.Right = X + Width
    bRECT.Bottom = Y + Height

    hBrush = CreateSolidBrush(Color)

    If OnlyBorder Then
        FrameRect DstDC, bRECT, hBrush
    Else
        FillRect DstDC, bRECT, hBrush
    End If

    DeleteObject hBrush
End Sub

Private Sub TransBlt(ByVal DstDC As Long, ByVal DstX As Long, ByVal DstY As Long, ByVal DstW As Long, ByVal DstH As Long, ByVal SrcPic As StdPicture, Optional ByVal IconState As IconStates = Icon_Normal, Optional ByVal ShadowColor As Long = -1)
    
    If DstW = 0 Or DstH = 0 Then Exit Sub
    
    Dim OriW As Long, OriH As Long
    Dim SrcDC As Long, SrcRect As RECT, SrcBmp As Long, SrcObj As Long

    Dim TmpDC As Long, TmpBmp As Long, TmpObj As Long
    Dim Data1() As RGBTRIPLE, Data2() As RGBTRIPLE
    Dim Info As BITMAPINFO, BrushRGB As RGBTRIPLE, gCol As Long
    Dim ToBeChange As Boolean
    Dim loopx As Long, loopy As Long
    Dim i As Long, iTop As Long, iLeft As Long
    Dim DisabledRGB As RGBTRIPLE, HighLightRGB As RGBTRIPLE, ShadowRGB As RGBTRIPLE
    Dim HaveChanged As Boolean

    OriW = UserControl.ScaleX(SrcPic.Width, vbHimetric, vbPixels)
    OriH = UserControl.ScaleY(SrcPic.Height, vbHimetric, vbPixels)
    
    Select Case IconState
    Case Icon_Normal
        Select Case SrcPic.Type
        Case vbPicTypeBitmap
            SrcDC = CreateCompatibleDC(hdc)
            SrcBmp = CreateCompatibleBitmap(hdc, DstW, DstH)
            SrcObj = SelectObject(SrcDC, SrcPic)
            
            StretchBlt DstDC, DstX, DstY, DstW, DstH, SrcDC, 0, 0, OriW, OriH, vbSrcCopy
            
'            DeleteObject SelectObject(SrcDC, SrcObj)
            DeleteObject SrcBmp
            DeleteDC SrcDC
        Case vbPicTypeIcon
            DrawIconEx DstDC, DstX, DstY, SrcPic.Handle, DstW, DstH, 0, 0, DI_NORMAL
        End Select
    
    Case Icon_Disabled
        
        Const cShadow = &H808080
        Const cHighLight = &HFFFFFF
        
        Select Case SrcPic.Type
        Case vbPicTypeBitmap
            DrawRectangle DstDC, DstX, DstY, DstW, DstH, cShadow
            Dim TmpRect As RECT
            TmpRect.Left = DstX
            TmpRect.Right = DstX + DstW
            TmpRect.Top = DstY
            TmpRect.Bottom = DstY + DstH
            DrawEdge DstDC, TmpRect, BDR_SUNKENINNER, BF_RECT
        Case vbPicTypeIcon
            SrcDC = CreateCompatibleDC(DstDC)
            SrcBmp = CreateCompatibleBitmap(DstDC, DstW, DstH)
            SrcObj = SelectObject(SrcDC, SrcBmp)
            BitBlt SrcDC, 0, 0, DstW, DstH, DstDC, DstX, DstY, vbSrcCopy
        
            TmpDC = CreateCompatibleDC(SrcDC)
            TmpBmp = CreateCompatibleBitmap(SrcDC, DstW, DstH)
            TmpObj = SelectObject(TmpDC, TmpBmp)
            BitBlt SrcDC, 0, 0, DstW, DstH, DstDC, DstX, DstY, vbSrcCopy
            DrawIconEx TmpDC, 0, 0, SrcPic.Handle, DstW, DstH, 0, 0, DI_NORMAL
            
            ReDim Data1(DstW * DstH * 3 - 1)
            ReDim Data2(UBound(Data1))
            With Info.bmiHeader
                .biSize = Len(Info.bmiHeader)
                .biWidth = DstW
                .biHeight = DstH
                .biPlanes = 1
                .biBitCount = 24
            End With
    
            GetDIBits SrcDC, SrcBmp, 0, DstH, Data1(0), Info, 0
            GetDIBits TmpDC, TmpBmp, 0, DstH, Data2(0), Info, 0
            
            With DisabledRGB
                .rgbBlue = (cShadow \ &H10000) Mod &H100
                .rgbGreen = (cShadow \ &H100) Mod &H100
                .rgbRed = cShadow And &HFF
            End With
            
            With HighLightRGB
                .rgbBlue = (cHighLight \ &H10000) Mod &H100
                .rgbGreen = (cHighLight \ &H100) Mod &H100
                .rgbRed = cHighLight And &HFF
            End With
    
            For loopy = 0 To DstH - 1
                For loopx = DstW - 1 To 0 Step -1
                    i = loopy * DstW + loopx
                    If Data2(i).rgbRed = Data1(i).rgbRed And Data2(i).rgbGreen = Data1(i).rgbGreen And Data2(i).rgbBlue = Data1(i).rgbBlue Then '±³¾°É«
                        HaveChanged = False
                        If loopy < DstH - 1 Then
                            iTop = (loopy + 1) * DstW + loopx
                            If Data2(iTop).rgbRed <> Data1(iTop).rgbRed Or Data2(iTop).rgbGreen <> Data1(iTop).rgbGreen Or Data2(iTop).rgbBlue <> Data1(iTop).rgbBlue Then
                                HaveChanged = True
                                Data2(i) = HighLightRGB
                            End If
                        End If
                        If loopx > 0 And (Not HaveChanged) Then
                            iLeft = i - 1
                            If Data2(iLeft).rgbRed <> Data1(iLeft).rgbRed Or Data2(iLeft).rgbGreen <> Data1(iLeft).rgbGreen Or Data2(iLeft).rgbBlue <> Data1(iLeft).rgbBlue Then
                                Data2(i) = HighLightRGB
                            End If
                        End If
                    Else
                        Data2(i) = DisabledRGB
                    End If
                Next
            Next

            SetDIBitsToDevice DstDC, DstX, DstY, DstW, DstH, 0, 0, 0, DstH, Data2(0), Info, 0

            Erase Data1, Data2
            DeleteObject SelectObject(TmpDC, TmpObj)
            DeleteObject TmpBmp
            DeleteDC TmpDC
            DeleteObject SelectObject(SrcDC, SrcObj)
            DeleteObject SrcBmp
            DeleteDC SrcDC
        
        End Select
        
    Case Icon_Grey
        
        If ShadowColor <> -1 Then
            With ShadowRGB
                .rgbBlue = (cShadow \ &H10000) Mod &H100
                .rgbGreen = (cShadow \ &H100) Mod &H100
                .rgbRed = cShadow And &HFF
            End With
        End If
        
        Select Case SrcPic.Type
        Case vbPicTypeBitmap
            SrcDC = CreateCompatibleDC(DstDC)
            SrcObj = SelectObject(SrcDC, SrcPic)
            
            TmpDC = CreateCompatibleDC(SrcDC)
            TmpBmp = CreateCompatibleBitmap(SrcDC, DstW, DstH)
            TmpObj = SelectObject(TmpDC, TmpBmp)
            StretchBlt TmpDC, 0, 0, DstW, DstH, SrcDC, 0, 0, OriW, OriH, vbSrcCopy
        
            ReDim Data2(DstW * DstH * 3 - 1)
            With Info.bmiHeader
                .biSize = Len(Info.bmiHeader)
                .biWidth = DstW
                .biHeight = DstH
                .biPlanes = 1
                .biBitCount = 24
            End With
            
            GetDIBits TmpDC, TmpBmp, 0, DstH, Data2(0), Info, 0
        
            For loopy = 0 To DstH - 1
                For loopx = DstW - 1 To 0 Step -1
                    i = loopy * DstW + loopx
                    If ShadowColor <> -1 Then
                        Data2(i) = ShadowRGB
                    Else
                        With Data2(i)
                            gCol = CLng(.rgbRed * 0.3) + .rgbGreen * 0.59 + .rgbBlue * 0.11
                            .rgbRed = gCol
                            .rgbGreen = gCol
                            .rgbBlue = gCol
                        End With
                    End If
                Next
            Next
        
            SetDIBitsToDevice DstDC, DstX, DstY, DstW, DstH, 0, 0, 0, DstH, Data2(0), Info, 0
        
            Erase Data2
            DeleteObject SelectObject(TmpDC, TmpObj)
            DeleteObject TmpBmp
            DeleteDC TmpDC
'            DeleteObject SelectObject(SrcDC, SrcObj)
            DeleteDC SrcDC
        Case vbPicTypeIcon
            SrcDC = CreateCompatibleDC(DstDC)
            SrcBmp = CreateCompatibleBitmap(DstDC, DstW, DstH)
            SrcObj = SelectObject(SrcDC, SrcBmp)
            BitBlt SrcDC, 0, 0, DstW, DstH, DstDC, DstX, DstY, vbSrcCopy
        
            TmpDC = CreateCompatibleDC(SrcDC)
            TmpBmp = CreateCompatibleBitmap(SrcDC, DstW, DstH)
            TmpObj = SelectObject(TmpDC, TmpBmp)
            BitBlt TmpDC, 0, 0, DstW, DstH, DstDC, DstX, DstY, vbSrcCopy
            DrawIconEx TmpDC, 0, 0, SrcPic.Handle, DstW, DstH, 0, 0, DI_NORMAL
            
            ReDim Data1(DstW * DstH * 3 - 1)
            ReDim Data2(UBound(Data1))
            With Info.bmiHeader
                .biSize = Len(Info.bmiHeader)
                .biWidth = DstW
                .biHeight = DstH
                .biPlanes = 1
                .biBitCount = 24
            End With
    
            GetDIBits SrcDC, SrcBmp, 0, DstH, Data1(0), Info, 0
            GetDIBits TmpDC, TmpBmp, 0, DstH, Data2(0), Info, 0
            
            For loopy = 0 To DstH - 1
                For loopx = DstW - 1 To 0 Step -1
                    i = loopy * DstW + loopx
                    If Data2(i).rgbRed <> Data1(i).rgbRed Or Data2(i).rgbGreen <> Data1(i).rgbGreen Or Data2(i).rgbBlue <> Data1(i).rgbBlue Then
                        If ShadowColor <> -1 Then
                            Data2(i) = ShadowRGB
                        Else
                            With Data2(i)
                                gCol = CLng(.rgbRed * 0.3) + .rgbGreen * 0.59 + .rgbBlue * 0.11
                                .rgbRed = gCol
                                .rgbGreen = gCol
                                .rgbBlue = gCol
                            End With
                        End If
                    End If
                Next
            Next
        
            SetDIBitsToDevice DstDC, DstX, DstY, DstW, DstH, 0, 0, 0, DstH, Data2(0), Info, 0
        
            Erase Data1, Data2
            DeleteObject SelectObject(TmpDC, TmpObj)
            DeleteObject TmpBmp
            DeleteDC TmpDC
            DeleteObject SelectObject(SrcDC, SrcObj)
            DeleteObject SrcBmp
            DeleteDC SrcDC
        End Select
    
    End Select

End Sub

Private Function PictureArea_Paint(DstDC As Long, Optional ByVal Force As Boolean = False) As Boolean

    Dim TmpRect As RECT
    Dim CoorLeft As Long, CoorTop As Long, FrameWidth As Long, FrameHeight As Long
    Dim DstX As Long, DstY As Long, DstW As Long, DstH As Long
    Dim AddInX As Long, AddInY As Long, AddInW As Long, AddInH As Long
    
    CoorLeft = PictureLayoutRect.Left - m_PictureMarginLeft
    CoorTop = PictureLayoutRect.Top - m_PictureMarginTop
    FrameWidth = m_PictureFrameWidth
    FrameHeight = m_PictureFrameHeight
    DstX = PictureLayoutRect.Left
    DstY = PictureLayoutRect.Top
    DstW = m_PictureFrameWidth - m_PictureMarginRight - m_PictureMarginLeft
    DstH = m_PictureFrameHeight - m_PictureMarginTop - m_PictureMarginBottom
    If Not picAddIn Is Nothing Then
        With m_ClientRect
            AddInX = .Right - m_AddinPicWidth - m_AddinAreaMargin
            AddInY = (0.5 * .Top + 0.5 * .Bottom) - 0.5 * m_AddinPicHeight
            AddInW = m_AddinPicWidth
            AddInH = m_AddinPicHeight
        End With
    End If
    
    Select Case m_ButtonType
    Case WindowsXPButton
        'UserControl.Ambient.UserMode = True
        If m_MouseDown Then
            If HasPicture And Not picOver Is Nothing Then
                PictureFrame_Paint DstDC, DstW, DstH
                TransBlt DstDC, DstX + 1, DstY + 1, DstW, DstH, picOver
            End If
            If Not picAddIn Is Nothing Then
                TransBlt DstDC, AddInX, AddInY, AddInW, AddInH, picAddIn
            End If
        ElseIf m_MouseOver Or m_HasFocus Then
            If HasPicture And Not picOver Is Nothing And (Force Or Not m_SamePic) Then
                PictureFrame_Paint DstDC, DstW, DstH
                TransBlt DstDC, DstX, DstY, DstW, DstH, picOver
            End If
            If Not picAddIn Is Nothing Then
                TransBlt DstDC, AddInX, AddInY, AddInW, AddInH, picAddIn
            End If
        ElseIf Enabled Or m_IgnoeDisEnabledEffect Then
            If HasPicture And (Not picNormal Is Nothing) And (Force Or Not m_SamePic) Then
                PictureFrame_Paint DstDC, DstW, DstH
                TransBlt DstDC, DstX, DstY, DstW, DstH, picNormal
            End If
            If Not picAddIn Is Nothing Then
                TransBlt DstDC, AddInX, AddInY, AddInW, AddInH, picAddIn
            End If
        Else
            If HasPicture And (Not picNormal Is Nothing) Then
                PictureFrame_Paint DstDC, DstW, DstH
                TransBlt DstDC, DstX, DstY, DstW, DstH, picNormal, Icon_Grey
            End If
            If Not picAddIn Is Nothing Then
                TransBlt DstDC, AddInX, AddInY, AddInW, AddInH, picAddIn, Icon_Grey
            End If
        End If
    
    Case OfficeXPButton, OfficeXPButtonPro
        If m_MouseDown Then
            If HasPicture And (Not picOver Is Nothing) Then
                PictureFrame_Paint DstDC, DstW, DstH
                TransBlt DstDC, DstX + 1, DstY + 1, DstW, DstH, picOver
            End If
            If Not picAddIn Is Nothing Then
                TransBlt DstDC, AddInX, AddInY, AddInW, AddInH, picAddIn
            End If
        ElseIf m_MouseOver Or m_HasFocus Then
            If HasPicture And (Not picOver Is Nothing) Then
                PictureFrame_Paint DstDC, DstW, DstH
                TransBlt DstDC, DstX + m_ShadowOffset, DstY + m_ShadowOffset, DstW, DstH, picOver, Icon_Grey, &H80000010
                TransBlt DstDC, DstX - 1, DstY - 1, DstW, DstH, picOver
            End If
            If Not picAddIn Is Nothing Then
                TransBlt DstDC, AddInX, AddInY, AddInW, AddInH, picAddIn
            End If
        ElseIf Enabled Or m_IgnoeDisEnabledEffect Then
            If HasPicture And (Not picNormal Is Nothing) Then
                PictureFrame_Paint DstDC, DstW, DstH
                TransBlt DstDC, DstX, DstY, DstW, DstH, picNormal
            End If
            If Not picAddIn Is Nothing Then
                TransBlt DstDC, AddInX, AddInY, AddInW, AddInH, picAddIn
            End If
        Else
            If HasPicture And (Not picNormal Is Nothing) Then
                PictureFrame_Paint DstDC, DstW, DstH
                TransBlt DstDC, DstX, DstY, DstW, DstH, picNormal, Icon_Grey
            End If
            If Not picAddIn Is Nothing Then
                TransBlt DstDC, AddInX, AddInY, AddInW, AddInH, picAddIn, Icon_Grey
            End If
        End If
    
    Case IEButton
        If m_MouseDown Then
            If HasPicture And (Not picOver Is Nothing) Then
                PictureFrame_Paint DstDC, DstW, DstH
                TransBlt DstDC, DstX + 1, DstY + 1, DstW, DstH, picOver
            End If
            If Not picAddIn Is Nothing Then
                TransBlt DstDC, AddInX, AddInY, AddInW, AddInH, picAddIn
            End If
        ElseIf m_MouseOver Or m_HasFocus Then
            If HasPicture And (Not picOver Is Nothing) Then
                PictureFrame_Paint DstDC, DstW, DstH
                TransBlt DstDC, DstX, DstY, DstW, DstH, picOver
            End If
            If Not picAddIn Is Nothing Then
                TransBlt DstDC, AddInX, AddInY, AddInW, AddInH, picAddIn
            End If
        ElseIf Enabled Or m_IgnoeDisEnabledEffect Then
            If HasPicture And (Not picNormal Is Nothing) Then
                PictureFrame_Paint DstDC, DstW, DstH
                TransBlt DstDC, DstX, DstY, DstW, DstH, picNormal, Icon_Grey
            End If
            If Not picAddIn Is Nothing Then
                TransBlt DstDC, AddInX, AddInY, AddInW, AddInH, picAddIn, Icon_Grey
            End If
        Else
            If HasPicture And (Not picNormal Is Nothing) Then
                PictureFrame_Paint DstDC, DstW, DstH
                TransBlt DstDC, DstX, DstY, DstW, DstH, picNormal, Icon_Disabled
            End If
            If Not picAddIn Is Nothing Then
                TransBlt DstDC, AddInX, AddInY, AddInW, AddInH, picAddIn, Icon_Disabled
            End If
        End If
    
    End Select
    
End Function
    
Private Sub PictureFrame_Paint(DstDC As Long, DstW As Long, DstH As Long)

    Dim TmpRect As RECT
    Dim CoorLeft As Long, CoorTop As Long, FrameWidth As Long, FrameHeight As Long
    
    CoorLeft = PictureLayoutRect.Left - m_PictureMarginLeft
    CoorTop = PictureLayoutRect.Top - m_PictureMarginTop
    FrameWidth = m_PictureFrameWidth
    FrameHeight = m_PictureFrameHeight
    
    'UserControl.Ambient.UserMode = True
    If m_PicFraBackColorEnabled Then
        DrawRectangle DstDC, CoorLeft, CoorTop, _
                      FrameWidth, FrameHeight, BreakApart(m_PicFraBackColor)
    End If
        
    If m_PicMaskColorEnabled Then
        With PictureLayoutRect
            DrawRectangle DstDC, .Left, .Top, DstW, DstH, BreakApart(m_PicMaskColor)
        End With
    End If
        
    Select Case m_PicFrameStyle
    Case Depressed
        TmpRect.Left = CoorLeft
        TmpRect.Right = CoorLeft + FrameWidth
        TmpRect.Top = CoorTop
        TmpRect.Bottom = CoorTop + FrameHeight
        DrawEdge DstDC, TmpRect, BDR_SUNKENINNER, BF_RECT
    Case Heave
        TmpRect.Left = CoorLeft
        TmpRect.Right = CoorLeft + FrameWidth
        TmpRect.Top = CoorTop
        TmpRect.Bottom = CoorTop + FrameHeight
        DrawEdge DstDC, TmpRect, BDR_RAISEDINNER, BF_RECT
    End Select
    
End Sub

Private Function ShiftColor(ByVal Color As Long, ByVal Value As Long, Optional isXP As Boolean = False) As Long
    Dim Red As Long, Blue As Long, Green As Long
    If Not isXP Then 'for XP button i use a work-aroud that works fine
        Value = Value \ 2 'this is just a tricky way to do it and will result in weird colors for WinXP and KDE2
        Blue = ((Color \ &H10000) Mod &H100) + Value
    Else
        Blue = ((Color \ &H10000) Mod &H100)
        Blue = Blue + ((Blue * Value) \ &HC0)
    End If
    Green = ((Color \ &H100) Mod &H100) + Value
    Red = (Color And &HFF) + Value
'a bit of optimization done here, values will overflow a byte only in one direction...
'eg: if we added 32 to our color, then only a > 255 overflow can occurr.
    If Value > 0 Then
        If Red > 255 Then Red = 255
        If Green > 255 Then Green = 255
        If Blue > 255 Then Blue = 255
    ElseIf Value < 0 Then
        If Red < 0 Then Red = 0
        If Green < 0 Then Green = 0
        If Blue < 0 Then Blue = 0
    End If
'more optimization by replacing the RGB function by its correspondent calculation
    ShiftColor = Red + 256& * Green + 65536 * Blue
End Function
Private Function SmoothColor(ByVal Color As Long) As Long
    Dim RColor As Integer, GColor As Integer, BColor As Integer
    RColor = getRedVal(Color)
    GColor = getGreenVal(Color)
    BColor = getBlueVal(Color)
    RColor = RColor + 76 - Int((RColor + 32) / 64) * 19
    GColor = GColor + 76 - Int((GColor + 32) / 64) * 19
    BColor = BColor + 76 - Int((BColor + 32) / 64) * 19
    SmoothColor = BreakApart(RGB(RColor, GColor, BColor))
End Function
Private Function getBlueVal(ByVal RGBCol As Long) As Integer
    RGBCol = Sys2RGB(RGBCol)
    If RGBCol < 0 Then RGBCol = 0
    getBlueVal = (RGBCol And &HFF0000) / &H10000
End Function
Private Function getGreenVal(ByVal RGBCol As Long) As Integer
    RGBCol = Sys2RGB(RGBCol)
    If RGBCol < 0 Then RGBCol = 0
    getGreenVal = ((RGBCol And &H100FF00) / &H100)
End Function
Private Function getRedVal(ByVal RGBCol As Long) As Integer
    RGBCol = Sys2RGB(RGBCol)
    If RGBCol < 0 Then RGBCol = 0
    getRedVal = RGBCol And &HFF
End Function
Private Function Sys2RGB(RGBCol As Long) As Long
    If RGBCol < 0 Then
        OleTranslateColor RGBCol, 0&, Sys2RGB
    Else
        Sys2RGB = RGBCol
    End If
End Function
Private Function BreakApart(ByVal Color As Long) As Long
    Dim R As Integer, G As Integer, B As Integer
    R = getRedVal(Color)
    G = getGreenVal(Color)
    B = getBlueVal(Color)
    BreakApart = RGB(R, G, B)
End Function
Private Function PlayASound(SoundFile As String) As Boolean
    PlayASound = PlaySound(SoundFile, vbNull, SND_FILENAME _
    + SND_ASYNC + SND_NOSTOP + SND_NOWAIT + SND_NODEFAULT)
End Function

Private Sub CalcAllRect()
    
    Dim picWidth As Integer, picHeight As Integer
        
    Select Case m_ButtonType
    Case WindowsXPButton, OfficeXPButton, IEButton, OfficeXPButtonPro
        If picAddIn Is Nothing Then
            Select Case m_ButtonType
            Case WindowsXPButton, OfficeXPButton
                m_AddinPicWidth = 0
                m_AddinPicHeight = 0
                m_AddinAreaMargin = 0
                m_AddinAreaWidth = m_AddinPicWidth + 2 * m_AddinAreaMargin
                PropertyChanged "PictureAddin_Width"
                PropertyChanged "PictureAddin_Height"
                PropertyChanged "PictureAddin_Margin"
            Case IEButton
                m_AddinPicWidth = 6
                m_AddinPicHeight = 3
                m_AddinAreaMargin = 4
                m_AddinAreaWidth = m_AddinPicWidth + 2 * m_AddinAreaMargin
                PropertyChanged "PictureAddin_Width"
                PropertyChanged "PictureAddin_Height"
                PropertyChanged "PictureAddin_Margin"
            Case OfficeXPButtonPro
                m_AddinPicWidth = 8
                m_AddinPicHeight = 15
                m_AddinAreaMargin = 4
                m_AddinAreaWidth = m_AddinPicWidth + 2 * m_AddinAreaMargin
                PropertyChanged "PictureAddin_Width"
                PropertyChanged "PictureAddin_Height"
                PropertyChanged "PictureAddin_Margin"
            End Select
            BeTodraw = True
        End If
        
        If m_AddinAreaWidth = 0 Then
            Call SetRect(AddinAreaRect, 0, 0, 0, 0)
        Else
            With m_ClientRect
                If .Right - .Left > m_AddinAreaWidth And .Bottom - .Top > m_AddinPicHeight Then
                    Call SetRect(AddinAreaRect, .Right - m_AddinAreaWidth, .Top, .Right, .Bottom)
                    Call CalcRect_PicFixSize_Caption
                    BeTodraw = True
                Else
                    BeTodraw = False
                End If
            End With
        End If

        If BeTodraw Then
            HasSeprator = False
            HasTBHandle = False
            HasUp_Down = IIf((m_ButtonType = WindowsXPButton Or m_ButtonType = OfficeXPButton), False, True)
            HasNextUp_down = False
                    
            Select Case m_CaptionAreaPercent
            Case 100
                HasPicture = False
                HasCaption = True
                With m_ClientRect
                    Call SetRect(CaptionAreaRect, .Left, .Top, .Right - m_AddinAreaWidth, .Bottom)
                End With
                CalcCaptionLayoutRect
            Case 0
                HasPicture = True
                HasCaption = False
                With m_ClientRect
                    Call SetRect(PictureAreaRect, .Left, .Top, .Right - m_AddinAreaWidth, .Bottom)
                End With
                CalcPictureLayoutRect
            Case Else
                Select Case m_ShowCaption And Len(m_Caption) > 0
                Case True
                    HasPicture = True
                    HasCaption = True
                    If m_ShowPictureFixSize Then
                        CalcRect_PicFixSize_Caption
                    Else
                        CalcRect_PicFixSize_Caption
                    End If
                Case False
                    HasPicture = True
                    HasCaption = False
                    With m_ClientRect
                        Call SetRect(PictureAreaRect, .Left, .Top, .Right - m_AddinAreaWidth, .Bottom)
                    End With
                    CalcPictureLayoutRect
                End Select
            End Select
        End If
    
    Case OfficeXPSeparator
        m_AddinAreaWidth = 0
        Call SetRect(AddinAreaRect, 0, 0, 0, 0)
        With m_ClientRect
            Call SetRect(PictureAreaRect, .Left, .Top, .Right, .Bottom)
        End With
        With PictureAreaRect
            Call SetRect(PictureAreaAwayOffsetRect, .Left + m_PictureMarginLeft, .Top + m_PictureMarginTop, .Right - m_PictureMarginRight, .Bottom - m_PictureMarginBottom)
        End With
        
        picWidth = PictureAreaAwayOffsetRect.Right - PictureAreaAwayOffsetRect.Left
        picHeight = PictureAreaAwayOffsetRect.Bottom - PictureAreaAwayOffsetRect.Top
    
        If picWidth > 0 And picHeight > 0 Then
            With PictureAreaAwayOffsetRect
                Call SetRect(PictureLayoutRect, .Left + Int(picWidth / 2), .Top, _
                            .Left + Int(picWidth / 2), .Bottom)
            End With
            BeTodraw = True
            HasPicture = False
            HasCaption = False
            HasSeprator = True
            HasTBHandle = False
            HasUp_Down = False
            HasNextUp_down = False
            If Enabled Then
                Enabled = Not Enabled
            End If
        Else
            BeTodraw = False
        End If
    
    Case OfficeXPHandle
        m_AddinAreaWidth = 0
        Call SetRect(AddinAreaRect, 0, 0, 0, 0)
        With m_ClientRect
            Call SetRect(PictureAreaRect, .Left, .Top, .Right, .Bottom)
        End With
        With PictureAreaRect
            Call SetRect(PictureAreaAwayOffsetRect, .Left + m_PictureMarginLeft, .Top + m_PictureMarginTop, .Right - m_PictureMarginRight, .Bottom - m_PictureMarginBottom)
        End With
         
        picWidth = PictureAreaAwayOffsetRect.Right - PictureAreaAwayOffsetRect.Left
        picHeight = PictureAreaAwayOffsetRect.Bottom - PictureAreaAwayOffsetRect.Top
    
        If picHeight > 0 And picHeight > m_TbarLineBetweenSpace Then
            If picWidth > 0 And picWidth > m_TBHandleThick Then
                With PictureAreaAwayOffsetRect
                    Call SetRect(PictureLayoutRect, .Left + Int((picWidth - m_TBHandleThick) / 2), .Top, _
                                .Left + Int((picWidth + m_TBHandleThick) / 2), .Bottom)
                End With
                BeTodraw = True
                HasPicture = False
                HasCaption = False
                HasSeprator = False
                HasTBHandle = True
                HasUp_Down = False
                HasNextUp_down = False
            Else
                BeTodraw = False
            End If
        Else
            BeTodraw = False
        End If
    
    Case HintsUp_DownArrow
        Call SetRect(PictureAreaRect, 0, 0, 0, 0)
        m_AddinAreaWidth = 0
        Call SetRect(AddinAreaRect, 0, 0, 0, 0)
        With m_ClientRect
            If .Right - .Left > m_AddinPicWidth And .Bottom - .Top > m_AddinPicHeight Then
                Call SetRect(CaptionAreaRect, .Left, .Top, .Right, .Bottom)
                BeTodraw = True
                HasPicture = False
                HasCaption = False
                HasSeprator = False
                HasTBHandle = False
                HasUp_Down = False
                HasNextUp_down = True
            Else
                BeTodraw = False
            End If
        End With
    End Select

End Sub

Private Sub CalcRect_PicFixSize_Caption()
    Dim AreaWidth As Long, AreaHeight As Long, AreaRight As Long

       
    AreaWidth = m_ClientRect.Right - m_ClientRect.Left - m_AddinAreaWidth
    AreaHeight = m_ClientRect.Bottom - m_ClientRect.Top
    AreaRight = m_ClientRect.Right - AddinAreaRect.Right + AddinAreaRect.Left
       
    Select Case m_CaptionAreaLayout
    Case LayoutLeft
        With m_ClientRect
            Call SetRect(PictureAreaRect, .Left + AreaWidth * m_CaptionAreaPercent * 0.01, .Top, AreaRight, .Bottom)
            Call SetRect(CaptionAreaRect, .Left, .Top, .Left + AreaWidth * m_CaptionAreaPercent * 0.01, .Bottom)
        End With

    Case LayoutRight
        With m_ClientRect
            Call SetRect(PictureAreaRect, .Left, .Top, AreaRight - AreaWidth * m_CaptionAreaPercent * 0.01, .Bottom)
            Call SetRect(CaptionAreaRect, AreaRight - AreaWidth * m_CaptionAreaPercent * 0.01, .Top, AreaRight, .Bottom)
        End With
        
    Case LayoutTop
        With m_ClientRect
            Call SetRect(PictureAreaRect, .Left, .Top + AreaHeight * m_CaptionAreaPercent * 0.01, AreaRight, .Bottom)
            Call SetRect(CaptionAreaRect, .Left, .Top, AreaRight, .Top + AreaHeight * m_CaptionAreaPercent * 0.01)
        End With
             
    Case LayoutBottom
        With m_ClientRect
            Call SetRect(PictureAreaRect, .Left, .Top, AreaRight, .Bottom - AreaHeight * m_CaptionAreaPercent * 0.01)
            Call SetRect(CaptionAreaRect, .Left, .Bottom - AreaHeight * m_CaptionAreaPercent * 0.01, AreaRight, .Bottom)
        End With
    Case CaptionOverPicture, PictureOverCaption
        With m_ClientRect
            Call SetRect(PictureAreaRect, .Left, .Top, AreaRight, .Bottom)
            Call SetRect(CaptionAreaRect, .Left, .Top, AreaRight, .Bottom)
        End With
    End Select
    
    CalcPictureLayoutRect
    CalcCaptionLayoutRect

End Sub

Private Sub CalcCaptionLayoutRect()
       
    With CaptionAreaRect
        Call SetRect(CaptionAreaAwayOffsetRect, .Left + m_CaptionMarginLeft, .Top + m_CaptionMarginTop, .Right - m_CaptionMarginRight, .Bottom - m_CaptionMarginBottom)
        Call SetRect(CaptionCalcRect, .Left + m_CaptionMarginLeft, .Top + m_CaptionMarginTop, .Right - m_CaptionMarginRight, .Bottom - m_CaptionMarginBottom)
    End With
       
    Select Case m_CaptionLayout
    Case BottomLeft
        If m_AutoMultiLine Then
            lngFormat = DT_WORDBREAK Or DT_LEFT
        Else
            lngFormat = DT_SINGLELINE Or DT_LEFT
        End If
        CaptionHeight = DrawText(UserControl.hdc, m_Caption, -1, CaptionCalcRect, lngFormat Or DT_CALCRECT)
            
            With CaptionAreaAwayOffsetRect
                Call SetRect(CaptionLayoutRect, .Left, .Bottom - CaptionHeight, .Right, .Bottom)
            End With
            
         Case BottomCenter
            If m_AutoMultiLine Then
                lngFormat = DT_WORDBREAK Or DT_CENTER
            Else
                lngFormat = DT_SINGLELINE Or DT_CENTER
            End If
                        
            CaptionHeight = DrawText(UserControl.hdc, m_Caption, -1, CaptionCalcRect, lngFormat Or DT_CALCRECT)
            
            With CaptionAreaAwayOffsetRect
                Call SetRect(CaptionLayoutRect, .Left, .Bottom - CaptionHeight, .Right, .Bottom)
            End With
         
         Case BottomRight
            If m_AutoMultiLine Then
                lngFormat = DT_WORDBREAK Or DT_RIGHT
            Else
                lngFormat = DT_SINGLELINE Or DT_RIGHT
            End If
                        
            CaptionHeight = DrawText(UserControl.hdc, m_Caption, -1, CaptionCalcRect, lngFormat Or DT_CALCRECT)
            
            With CaptionAreaAwayOffsetRect
                Call SetRect(CaptionLayoutRect, .Left, .Bottom - CaptionHeight, .Right, .Bottom)
            End With
         
         Case CenterLeft
            If m_AutoMultiLine Then
                lngFormat = DT_WORDBREAK Or DT_LEFT
            Else
                lngFormat = DT_SINGLELINE Or DT_LEFT
            End If
                        
            CaptionHeight = DrawText(UserControl.hdc, m_Caption, -1, CaptionCalcRect, lngFormat Or DT_CALCRECT)
            
            With CaptionAreaAwayOffsetRect
                Call SetRect(CaptionLayoutRect, .Left, .Top + Int((.Bottom - .Top) / 2 - CaptionHeight / 2), .Right, .Top + Int((.Bottom - .Top) / 2 + CaptionHeight / 2))
            End With
         
         Case CenterCenter
            If m_AutoMultiLine Then
                lngFormat = DT_WORDBREAK Or DT_CENTER
            Else
                lngFormat = DT_SINGLELINE Or DT_CENTER
            End If
                        
            CaptionHeight = DrawText(UserControl.hdc, m_Caption, -1, CaptionCalcRect, lngFormat Or DT_CALCRECT)
            
            With CaptionAreaAwayOffsetRect
                Call SetRect(CaptionLayoutRect, .Left, .Top + Int((.Bottom - .Top) / 2 - CaptionHeight / 2), .Right, .Top + Int((.Bottom - .Top) / 2 + CaptionHeight / 2))
            End With
            
         Case CenterRight
            If m_AutoMultiLine Then
                lngFormat = DT_WORDBREAK Or DT_RIGHT
            Else
                lngFormat = DT_SINGLELINE Or DT_RIGHT
            End If
                        
            CaptionHeight = DrawText(UserControl.hdc, m_Caption, -1, CaptionCalcRect, lngFormat Or DT_CALCRECT)
            
            With CaptionAreaAwayOffsetRect
                Call SetRect(CaptionLayoutRect, .Left, .Top + Int((.Bottom - .Top) / 2 - CaptionHeight / 2), .Right, .Top + Int((.Bottom - .Top) / 2 + CaptionHeight / 2))
            End With
         
         Case TopLeft
            If m_AutoMultiLine Then
                lngFormat = DT_WORDBREAK Or DT_LEFT
            Else
                lngFormat = DT_SINGLELINE Or DT_LEFT
            End If
            
            CaptionHeight = DrawText(UserControl.hdc, m_Caption, -1, CaptionCalcRect, lngFormat Or DT_CALCRECT)
            
            With CaptionAreaAwayOffsetRect
                Call SetRect(CaptionLayoutRect, .Left, .Top, .Right, .Top + CaptionHeight)
            End With
         
         Case TopCenter
            If m_AutoMultiLine Then
                lngFormat = DT_WORDBREAK Or DT_CENTER
            Else
                lngFormat = DT_SINGLELINE Or DT_CENTER
            End If
                        
            CaptionHeight = DrawText(UserControl.hdc, m_Caption, -1, CaptionCalcRect, lngFormat Or DT_CALCRECT)
            
            With CaptionAreaAwayOffsetRect
                Call SetRect(CaptionLayoutRect, .Left, .Top, .Right, .Top + CaptionHeight)
            End With
         
         Case TopRight
            If m_AutoMultiLine Then
                lngFormat = DT_WORDBREAK Or DT_RIGHT
            Else
                lngFormat = DT_SINGLELINE Or DT_RIGHT
            End If
                        
            CaptionHeight = DrawText(UserControl.hdc, m_Caption, -1, CaptionCalcRect, lngFormat Or DT_CALCRECT)
            
            With CaptionAreaAwayOffsetRect
                Call SetRect(CaptionLayoutRect, .Left, .Top, .Right, .Top + CaptionHeight)
            End With
            
       End Select

End Sub

Private Sub CalcPictureLayoutRect()
    Dim picWidth As Integer, picHeight As Integer
    Dim CoorX As Integer, CoorY As Integer
       
    With PictureAreaRect
        Call SetRect(PictureAreaAwayOffsetRect, .Left + m_PictureMarginLeft, .Top + m_PictureMarginTop, .Right - m_PictureMarginRight, .Bottom - m_PictureMarginBottom)
    End With
   
    If m_MouseOver Or m_MouseDown Or m_HasFocus Then
        If picOver Is Nothing Then
            picWidth = 0
            picHeight = 0
        Else
            picWidth = m_PictureFrameWidth - m_PictureMarginRight - m_PictureMarginLeft
            picHeight = m_PictureFrameHeight - m_PictureMarginBottom - m_PictureMarginTop
        End If
    Else
        If picNormal Is Nothing Then
            picWidth = 0
            picHeight = 0
        Else
            picWidth = m_PictureFrameWidth - m_PictureMarginRight - m_PictureMarginLeft
            picHeight = m_PictureFrameHeight - m_PictureMarginBottom - m_PictureMarginTop
        End If
    End If
       
    Select Case m_PictureLayout
         Case BottomLeft
            With PictureAreaAwayOffsetRect
                Call SetRect(PictureLayoutRect, .Left, .Bottom - picHeight, .Left + picWidth, .Bottom)
            End With
            
         Case BottomCenter
            With PictureAreaAwayOffsetRect
                CoorX = Int((.Right + .Left) / 2 - picWidth / 2)
                Call SetRect(PictureLayoutRect, CoorX, .Bottom - picHeight, CoorX + picWidth, .Bottom)
            End With
         
         Case BottomRight
            With PictureAreaAwayOffsetRect
                Call SetRect(PictureLayoutRect, .Right - picWidth, .Bottom - picHeight, .Right, .Bottom)
            End With
         
         Case CenterLeft
            With PictureAreaAwayOffsetRect
                CoorY = Int((.Bottom + .Top) / 2 - picHeight / 2)
                Call SetRect(PictureLayoutRect, .Left, CoorY, .Left + picWidth, CoorY + picHeight)
            End With
    
         Case CenterCenter
            With PictureAreaAwayOffsetRect
                CoorX = Int((.Right + .Left) / 2 - picWidth / 2)
                CoorY = Int((.Bottom + .Top) / 2 - picHeight / 2)
                Call SetRect(PictureLayoutRect, CoorX, CoorY, CoorX + picWidth, CoorY + picHeight)
            End With
            
         Case CenterRight
            With PictureAreaAwayOffsetRect
                CoorY = Int((.Bottom + .Top) / 2 - picHeight / 2)
                Call SetRect(PictureLayoutRect, .Right - picWidth, CoorY, .Right, CoorY + picHeight)
            End With
               
         Case TopLeft
            With PictureAreaAwayOffsetRect
                Call SetRect(PictureLayoutRect, .Left, .Top, .Left + picWidth, .Top + picHeight)
            End With
         
         Case TopCenter
            With PictureAreaAwayOffsetRect
                CoorX = Int((.Right + .Left) / 2 - picWidth / 2)
                Call SetRect(PictureLayoutRect, CoorX, .Top, CoorX + picWidth, .Top + picHeight)
            End With
         
         Case TopRight
            With PictureAreaAwayOffsetRect
                Call SetRect(PictureLayoutRect, .Right - picWidth, .Top, .Right, .Top + picHeight)
            End With
            
       End Select

End Sub

Private Sub DrawUp_DownArrow(ByVal DrawColor As Long)
    
    Dim Poly(1 To 3) As POINTAPI
    Dim hTmpBrush As Long
    Dim TmpRGBColor2 As Long
    Dim hRgn As Long
    Dim CoorX As Long, CoorY As Long, HalfWidth As Long, HalfHeight As Long
    
    Select Case m_ButtonType
    Case OfficeXPButtonPro
        With AddinAreaRect
            HalfWidth = m_AddinPicWidth / 2
            CoorX = .Left + Int((.Right - .Left) / 2) - HalfWidth
            HalfHeight = m_AddinPicHeight / 2
            CoorY = .Top + Int((.Bottom - .Top) / 2)
        End With
        Poly(1).X = CoorX
        Poly(1).Y = CoorY - HalfHeight
        Poly(2).X = CoorX + 2 * HalfWidth
        Poly(2).Y = CoorY
        Poly(3).X = CoorX
        Poly(3).Y = CoorY + HalfHeight
    
    Case IEButton
        With AddinAreaRect
            HalfWidth = m_AddinPicWidth / 2
            CoorX = .Left + Int((.Right - .Left) / 2) - HalfWidth
            CoorY = .Top + Int((.Bottom - .Top - m_AddinPicHeight) / 2)
        End With
        Poly(1).X = CoorX
        Poly(1).Y = CoorY
        Poly(2).X = CoorX + 2 * HalfWidth
        Poly(2).Y = CoorY
        Poly(3).X = CoorX + HalfWidth
        Poly(3).Y = CoorY + m_AddinPicHeight
    End Select
    
    TmpRGBColor2 = BreakApart(DrawColor)
    hTmpBrush = CreateSolidBrush(TmpRGBColor2)
    hRgn = CreatePolygonRgn(Poly(1), 3, ALTERNATE)
    If hRgn Then FillRgn hdc, hRgn, hTmpBrush
    DeleteObject hRgn
    DeleteObject hTmpBrush

End Sub

Private Sub DrawNextUp_DownArrow(ByVal DrawColor As Long)
    
    Dim Poly(1 To 3) As POINTAPI
    Dim DotPoint(1 To 20) As POINTAPI
    Dim hTmpBrush As Long
    Dim TmpRGBColor2 As Long
    Dim hRgn As Long
    Dim i As Integer
    Dim CoorX As Integer, CoorY As Integer, HalfWidth As Integer
    
    With CaptionAreaRect
        HalfWidth = m_AddinPicWidth / 2
        CoorX = .Left + Int((.Right - .Left) / 2) - HalfWidth
        CoorY = .Top + Int((.Bottom - .Top - m_AddinPicHeight) / 2)
    End With
    
    DotPoint(1).X = CoorX
    DotPoint(1).Y = CoorY
    DotPoint(2).X = CoorX + 1
    DotPoint(2).Y = CoorY
    DotPoint(3).X = CoorX + 1
    DotPoint(3).Y = CoorY + 1
    DotPoint(4).X = CoorX + 2
    DotPoint(4).Y = CoorY + 1
    DotPoint(5).X = CoorX + 2
    DotPoint(5).Y = CoorY + 2
    DotPoint(6).X = CoorX + 3
    DotPoint(6).Y = CoorY + 2
    DotPoint(7).X = CoorX + 1
    DotPoint(7).Y = CoorY + 3
    DotPoint(8).X = CoorX + 2
    DotPoint(8).Y = CoorY + 3
    DotPoint(9).X = CoorX
    DotPoint(9).Y = CoorY + 4
    DotPoint(10).X = CoorX + 1
    DotPoint(10).Y = CoorY + 4
        
    DotPoint(11).X = CoorX + 4
    DotPoint(11).Y = CoorY
    DotPoint(12).X = CoorX + 5
    DotPoint(12).Y = CoorY
    DotPoint(13).X = CoorX + 5
    DotPoint(13).Y = CoorY + 1
    DotPoint(14).X = CoorX + 6
    DotPoint(14).Y = CoorY + 1
    DotPoint(15).X = CoorX + 6
    DotPoint(15).Y = CoorY + 2
    DotPoint(16).X = CoorX + 7
    DotPoint(16).Y = CoorY + 2
    DotPoint(17).X = CoorX + 5
    DotPoint(17).Y = CoorY + 3
    DotPoint(18).X = CoorX + 6
    DotPoint(18).Y = CoorY + 3
    DotPoint(19).X = CoorX + 4
    DotPoint(19).Y = CoorY + 4
    DotPoint(20).X = CoorX + 5
    DotPoint(20).Y = CoorY + 4
        
    Poly(1).X = CoorX + 1
    Poly(1).Y = CoorY + m_AddinPicHeight - 3
    Poly(2).X = CoorX + m_AddinPicWidth - 1
    Poly(2).Y = CoorY + m_AddinPicHeight - 3
    Poly(3).X = CoorX + HalfWidth
    Poly(3).Y = CoorY + m_AddinPicHeight
    
    TmpRGBColor2 = BreakApart(DrawColor)
    
    For i = 1 To 20
        Call SetPixel(hdc, DotPoint(i).X, DotPoint(i).Y, TmpRGBColor2)
    Next i
    
    hTmpBrush = CreateSolidBrush(TmpRGBColor2)
    hRgn = CreatePolygonRgn(Poly(1), 3, ALTERNATE)
    If hRgn Then FillRgn hdc, hRgn, hTmpBrush
    DeleteObject hRgn
    DeleteObject hTmpBrush

End Sub
