%% This is an -*- erlang -*- file.
%%
%% %CopyrightBegin%
%%
%% Copyright Ericsson AB 2010-2016. All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%
%% %CopyrightEnd%

{application, wx,
 [{description, "Yet another graphics system"},
  {vsn, "1.8.3"},
  {modules,
   [
    %% Generated modules
  wxBitmapButton, wxImage, wxGraphicsContext, wxPreviewFrame, wxCheckListBox, wxEvtHandler, wxFileDialog, wxFlexGridSizer, wxPrintDialogData, wxColourData, wxMouseCaptureChangedEvent, wxDCOverlay, wxClipboardTextEvent, wxMoveEvent, wxChoicebook, wxSystemOptions, wxGridCellFloatRenderer, wxGridCellAttr, wxWindowDC, wxColourDialog, wxHtmlLinkEvent, wxStatusBar, wxInitDialogEvent, wxEraseEvent, wxXmlResource, wxTaskBarIconEvent, wxGraphicsObject, wxPrintout, wxDateEvent, wxSysColourChangedEvent, wxLocale, wxGraphicsMatrix, wxBitmap, wxQueryNewPaletteEvent, wxSizerItem, wxGridCellBoolRenderer, wxDC, wxPasswordEntryDialog, wxNavigationKeyEvent, wxFontData, wxGraphicsRenderer, wxMouseCaptureLostEvent, wxTextEntryDialog, wxIdleEvent, wxStyledTextCtrl, wxListItem, wxSpinCtrl, wxGLCanvas, wxMDIClientWindow, wxMDIChildFrame, wxStdDialogButtonSizer, wxPrintPreview, wxPrintData, wxDirPickerCtrl, wxKeyEvent, wxEvent, wxFontDialog, wxRadioBox, wxCalendarDateAttr, wxGridCellEditor, wxPalette, wxGridCellNumberRenderer, wxSizeEvent, wxLogNull, wxPreviewCanvas, wxTextAttr, wxScrollWinEvent, wxJoystickEvent, wxGraphicsBrush, wxWindowDestroyEvent, wxSetCursorEvent, wxChoice, wxControl, wxActivateEvent, wxGraphicsFont, wxStaticText, wxCalendarCtrl, wxIconizeEvent, wxPrinter, wxGridBagSizer, wxGridSizer, wxScrollEvent, wx_misc, wxWindowCreateEvent, wxGridCellFloatEditor, wxPrintDialog, wxStaticBox, wxBufferedDC, wxTextCtrl, wxRadioButton, wxClientDC, wxStaticBitmap, wxListCtrl, wxCalendarEvent, wxGauge, wxSizerFlags, wxGridCellTextEditor, wxShowEvent, wxBitmapDataObject, wxFindReplaceDialog, wxFrame, wxGraphicsPath, wxMiniFrame, wxDisplayChangedEvent, wxListEvent, wxCursor, wxDialog, wxBrush, wxTopLevelWindow, wxPaintDC, wxScreenDC, wxFileDataObject, wxPopupWindow, wxColourPickerCtrl, wxFilePickerCtrl, wxFindReplaceData, wxPostScriptDC, wxGrid, wxAuiSimpleTabArt, wxSashEvent, wxMask, wxSplitterEvent, wxScrollBar, wxMenuEvent, wxPaletteChangedEvent, wxListItemAttr, wxMirrorDC, wxAuiManager, wxFileDirPickerEvent, wxBoxSizer, wxClipboard, wxMouseEvent, wxDirDialog, wxMenu, wxAuiPaneInfo, wxPaintEvent, wxSplitterWindow, wxProgressDialog, wxCheckBox, wxNotebookEvent, wxColourPickerEvent, wxMenuItem, wxChildFocusEvent, wxMessageDialog, wxButton, wxMenuBar, wxToggleButton, wxToolBar, wxGraphicsPen, wxArtProvider, wxHtmlEasyPrinting, wxNotebook, wxBufferedPaintDC, wxTreeCtrl, wxRegion, wxListView, wxAuiManagerEvent, wxContextMenuEvent, wxLayoutAlgorithm, wxGridCellBoolEditor, wxMultiChoiceDialog, wxOverlay, wxTaskBarIcon, wxAuiDockArt, wxDropFilesEvent, wxHtmlWindow, wxComboBox, wxScrolledWindow, wxCommandEvent, wxPanel, wxDataObject, wxGridCellRenderer, wxSashWindow, wxDatePickerCtrl, wxFocusEvent, wxGridCellChoiceEditor, wxListbook, wxImageList, wxAuiNotebook, wxNotifyEvent, wxToolTip, wxSlider, wxSizer, wxGBSizerItem, wxPen, wxListBox, wxPickerBase, wxAuiNotebookEvent, wxMaximizeEvent, wxStaticBoxSizer, wxUpdateUIEvent, wxIcon, wxPageSetupDialogData, wxMemoryDC, wxGridCellStringRenderer, wxPopupTransientWindow, wxPageSetupDialog, wxAcceleratorEntry, wxFontPickerCtrl, wxCloseEvent, wxTextDataObject, wxCaret, wxStyledTextEvent, wxAcceleratorTable, wxMDIParentFrame, wxPreviewControlBar, wxHelpEvent, wxStaticLine, wxGenericDirCtrl, wxToolbook, wxFont, wxGridCellNumberEditor, wxControlWithItems, wxSystemSettings, wxWindow, wxTreeEvent, wxSplashScreen, wxSpinEvent, wxSingleChoiceDialog, wxFontPickerEvent, wxAuiTabArt, wxIconBundle, wxSpinButton, wxTreebook, wxSashLayoutWindow, wxGridEvent, glu, gl,
    %% Handcrafted modules
    wx,
    wx_object,
    wxe_master,
    wxe_server,
    wxe_util
   ]},
  {registered, []},
  {applications, [stdlib, kernel]},
  {env, []},
  {runtime_dependencies, ["stdlib-2.0","kernel-3.0","erts-6.0"]}
 ]}.
