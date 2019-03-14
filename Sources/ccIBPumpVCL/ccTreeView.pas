{
  Copyright (c) 2000-2002 CleverComponents.com
  Product: CleverComponents Interbase DataPump VCL
  Author: Alexandre Poloziouk, alex@CleverComponents.com
  Unit: ccTreeView.pas
  Version: 1.0
    This unit based on Borland TTreeView component sources.
}

unit ccTreeView;

{$INCLUDE ccGetVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, 
  ComCtrls, CommCtrl, ExtCtrls, imglist;

type

{ Common }

  TccScrollDestStyle = (scdsLeft, scdsRight, scdsTop, scdsBottom);
  TccScrollDest = set of TccScrollDestStyle;
  TccSearchTreeViewEvent = procedure(var Message: TMessage) of object;

{ TccTreeNode }

  TccCustomTreeView = class;
  TccTreeNodes = class;

  TccNodeState = (nsBold, nsCut, nsDropHilited, nsFocused, nsSelected, nsExpanded, nsExpandedOnce, nsExpandPartial);
  TccNodeAttachMode = (naAdd, naAddFirst, naAddChild, naAddChildFirst, naInsert);
  TccAddMode = (taAddFirst, taAdd, taInsert);

  PTccNodeInfo = ^TccNodeInfo;
  TccNodeInfo = packed record
    Checked: Boolean;
    Bold: Boolean;
    ImageIndex: Integer;
    SelectedIndex: Integer;
    StateIndex: Integer;
    OverlayIndex: Integer;
    Data: Pointer;
    Count: Integer;
    TextLen: integer;
    InfoTextLen: integer;
  end;

  TccTreeNode = class(TPersistent)
  private
    FOwner: TccTreeNodes;
    FText: string;
    FInfoText: string;
    FData: Pointer;
    FItemId: HTreeItem;
    FBold: Boolean;
    FImageIndex: Integer;
    FSelectedIndex: Integer;
    FOverlayIndex: Integer;
    FStateIndex: Integer;
    FDeleting: Boolean;
    FInTree: Boolean;
    FTag: integer;
    function CompareCount(CompareMe: Integer): Boolean;
    function DoCanExpand(Expand: Boolean): Boolean;
    procedure DoExpand(Expand: Boolean);
    procedure ExpandItem(Expand: Boolean; Recurse: Boolean);
    function GetAbsoluteIndex: Integer;
    function GetExpanded: Boolean;
    function GetLevel: Integer;
    function GetParent: TccTreeNode;
    function GetChildren: Boolean;
    function GetCut: Boolean;
    function GetDropTarget: Boolean;
    function GetFocused: Boolean;
    function GetIndex: Integer;
    function GetItem(Index: Integer): TccTreeNode;
    function GetSelected: Boolean;
    function GetState(NodeState: TccNodeState): Boolean;
    function GetChecked: Boolean;
    function GetCount: Integer;
    function GetTreeView: TccCustomTreeView;
    procedure InternalMove(ParentNode, Node: TccTreeNode; HItem: HTreeItem;
      AddMode: TccAddMode);
    function IsEqual(Node: TccTreeNode): Boolean;
    function IsNodeVisible: Boolean;
    procedure ReadData(Stream: TStream; PRec: PTccNodeInfo);
    procedure SetChildren(Value: Boolean);
    procedure SetCut(Value: Boolean);
    procedure SetData(Value: Pointer);
    procedure SetDropTarget(Value: Boolean);
    procedure SetItem(Index: Integer; Value: TccTreeNode);
    procedure SetExpanded(Value: Boolean);
    procedure SetFocused(Value: Boolean);
    procedure SetImageIndex(Value: Integer);
    procedure SetBold(Value: Boolean);
    procedure SetOverlayIndex(Value: Integer);
    procedure SetSelectedIndex(Value: Integer);
    procedure SetSelected(Value: Boolean);
    procedure SetStateIndex(Value: Integer);
    procedure SetText(const S: string);
    procedure SetInfoText(const S: string);
    procedure SetChecked(Value: Boolean);
    procedure WriteData(Stream: TStream; PRec: PTccNodeInfo);
    function GetExpandedOnce: boolean;
    procedure SetExpandedOnce(Value: boolean);
    function GetExpandPartial: boolean;
    procedure SetExpandPartial(Value: boolean);
    function GetTheText: string;
  public
    constructor Create(AOwner: TccTreeNodes);
    destructor Destroy; override;
    function AlphaSort: Boolean;
    procedure Assign(Source: TPersistent); override;
    procedure Collapse(Recurse: Boolean);
    function CustomSort(SortProc: TTVCompare; Data: Longint): Boolean;
    procedure Delete;
    procedure DeleteChildren;
    function DisplayRect(TextOnly: Boolean): TRect;
    function EditText: Boolean;
    procedure EndEdit(Cancel: Boolean);
    procedure Expand(Recurse: Boolean);
    function GetFirstChild: TccTreeNode;
    function GetHandle: HWND;
    function GetLastChild: TccTreeNode;
    function GetNext: TccTreeNode;
    function GetNextChild(Value: TccTreeNode): TccTreeNode;
    function GetNextSibling: TccTreeNode;
    function GetNextVisible: TccTreeNode;
    function GetPrev: TccTreeNode;
    function GetPrevChild(Value: TccTreeNode): TccTreeNode;
    function GetPrevSibling: TccTreeNode;
    function GetPrevVisible: TccTreeNode;
    function HasAsParent(Value: TccTreeNode): Boolean;
    function IndexOf(Value: TccTreeNode): Integer;
    procedure MakeVisible;
    procedure MoveTo(Destination: TccTreeNode; Mode: TccNodeAttachMode); virtual;
    property AbsoluteIndex: Integer read GetAbsoluteIndex;
    property Count: Integer read GetCount;
    property Cut: Boolean read GetCut write SetCut;
    property Data: Pointer read FData write SetData;
    property Deleting: Boolean read FDeleting;
    property Focused: Boolean read GetFocused write SetFocused;
    property DropTarget: Boolean read GetDropTarget write SetDropTarget;
    property Selected: Boolean read GetSelected write SetSelected;
    property Expanded: Boolean read GetExpanded write SetExpanded;
    property Handle: HWND read GetHandle;
    property HasChildren: Boolean read GetChildren write SetChildren;
    property Bold: Boolean read FBold write SetBold;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    property Index: Integer read GetIndex;
    property IsVisible: Boolean read IsNodeVisible;
    property Item[Index: Integer]: TccTreeNode read GetItem write SetItem; default;
    property ItemId: HTreeItem read FItemId;
    property Level: Integer read GetLevel;
    property OverlayIndex: Integer read FOverlayIndex write SetOverlayIndex;
    property Owner: TccTreeNodes read FOwner;
    property Parent: TccTreeNode read GetParent;
    property SelectedIndex: Integer read FSelectedIndex write SetSelectedIndex;
    property StateIndex: Integer read FStateIndex write SetStateIndex;
    property Text: string read FText write SetText;
    property TheText: string read GetTheText;
    property InfoText: string read FInfoText write SetInfoText;
    property Checked: Boolean read GetChecked write SetChecked;
    property TreeView: TccCustomTreeView read GetTreeView;
    property ExpandedOnce: boolean read GetExpandedOnce write SetExpandedOnce;
    property ExpandPartial: boolean read GetExpandPartial write SetExpandPartial;
    property Tag: integer read FTag write FTag;
  end;

{ TccTreeNodes }

  TccTreeNodes = class(TPersistent)
  private
    FOwner: TccCustomTreeView;
    FUpdateCount: Integer;
    procedure AddedNode(Value: TccTreeNode);
    function GetHandle: HWND;
    function GetNodeFromIndex(Index: Integer): TccTreeNode;
    procedure ReadData(Stream: TStream);
    procedure Repaint(Node: TccTreeNode);
    procedure WriteData(Stream: TStream);
  protected
    function AddItem(Parent, Target: HTreeItem; const Item: TTVItem;
      AddMode: TccAddMode): HTreeItem;
    function InternalAddObject(Node: TccTreeNode; const S: string;
      Ptr: Pointer; AddMode: TccAddMode): TccTreeNode;
    procedure DefineProperties(Filer: TFiler); override;
    function CreateItem(Node: TccTreeNode): TTVItem;
    function GetCount: Integer;
    procedure SetItem(Index: Integer; Value: TccTreeNode);
    procedure SetUpdateState(Updating: Boolean);
  public
    constructor Create(AOwner: TccCustomTreeView);
    destructor Destroy; override;
    function AddChildFirst(Node: TccTreeNode; const S: string): TccTreeNode;
    function AddChild(Node: TccTreeNode; const S: string): TccTreeNode;
    function AddChildObjectFirst(Node: TccTreeNode; const S: string;
      Ptr: Pointer): TccTreeNode;
    function AddChildObject(Node: TccTreeNode; const S: string;
      Ptr: Pointer): TccTreeNode;
    function AddFirst(Node: TccTreeNode; const S: string): TccTreeNode;
    function Add(Node: TccTreeNode; const S: string): TccTreeNode;
    function AddObjectFirst(Node: TccTreeNode; const S: string;
      Ptr: Pointer): TccTreeNode;
    function AddObject(Node: TccTreeNode; const S: string;
      Ptr: Pointer): TccTreeNode;
    procedure Assign(Source: TPersistent); override;
    procedure BeginUpdate;
    procedure Clear;
    procedure Delete(Node: TccTreeNode);
    procedure EndUpdate;
    function GetFirstNode: TccTreeNode;
    function GetNode(ItemId: HTreeItem): TccTreeNode;
    function Insert(Node: TccTreeNode; const S: string): TccTreeNode;
    function InsertObject(Node: TccTreeNode; const S: string;
      Ptr: Pointer): TccTreeNode;
    property Count: Integer read GetCount;
    property Handle: HWND read GetHandle;
    property Item[Index: Integer]: TccTreeNode read GetNodeFromIndex; default;
    property Owner: TccCustomTreeView read FOwner;
  end;

{ TccCustomTreeView }

  TccHitTest = (htAbove, htBelow, htNowhere, htOnItem, htOnButton,
    htOnIcon, htOnIndent, htOnLabel, htOnRight,
    htOnStateIcon, htToLeft, htToRight);
  TccHitTests = set of TccHitTest;
  ETreeViewError = class(Exception);

  TccChangingEvent = procedure(Sender: TObject; Node: TccTreeNode;
    var AllowChange: Boolean) of object;
  TccChangedEvent = procedure(Sender: TObject; Node: TccTreeNode) of object;
  TccEditingEvent = procedure(Sender: TObject; Node: TccTreeNode;
    var AllowEdit: Boolean) of object;
  TccEditedEvent = procedure(Sender: TObject; Node: TccTreeNode; var S: string) of object;
  TccExpandingEvent = procedure(Sender: TObject; Node: TccTreeNode;
    var AllowExpansion: Boolean) of object;
  TccCollapsingEvent = procedure(Sender: TObject; Node: TccTreeNode;
    var AllowCollapse: Boolean) of object;
  TccExpandedEvent = procedure(Sender: TObject; Node: TccTreeNode) of object;
  TccCompareEvent = procedure(Sender: TObject; Node1, Node2: TccTreeNode;
    Data: Integer; var Compare: Integer) of object;
  TccTVInfoTip = procedure(Node: TccTreeNode; var InfoTip: string) of object;
  TccTreeViewCustomDraw = procedure(Sender : TObject; TreeNode : TccTreeNode; AFont : TFont;
                                  var AColor, ABkColor : TColor) of object;


  TccSortType = (stNone, stData, stText, stBoth);
  TccCheckChangingEvent = procedure(Sender: TObject; Node: TccTreeNode; var CanCheck: boolean) of object;
  TccCheckChangedEvent = procedure(Sender: TObject; Node: TccTreeNode) of object;

  TccCustomTreeView = class(TWinControl)
  private
    FShowLines: Boolean;
    FShowRoot: Boolean;
    FShowButtons: Boolean;
    FBorderStyle: TBorderStyle;
    FReadOnly: Boolean;
    FImages: TImageList;
    FStateImages: TImageList;
    FImageChangeLink: TChangeLink;
    FStateChangeLink: TChangeLink;
    FDragImage: TDragImageList;
    FTreeNodes: TccTreeNodes;
    FSortType: TccSortType;
    FSaveItems: TStringList;
    FSaveTopIndex: Integer;
    FSaveIndex: Integer;
    FSaveIndent: Integer;
    FHideSelection: Boolean;
    FMemStream: TMemoryStream;
    FEditInstance: Pointer;
    FDefEditProc: Pointer;
    FEditHandle: HWND;
    FDragged: Boolean;
    FRClickNode: TccTreeNode;
    FLastDropTarget: TccTreeNode;
    FDragNode: TccTreeNode;
    FManualNotify: Boolean;
    FRightClickSelect: Boolean;
    FStateChanging: Boolean;
    FWideText: WideString;
    FOnEditing: TccEditingEvent;
    FOnEdited: TccEditedEvent;
    FOnExpanded: TccExpandedEvent;
    FOnExpanding: TccExpandingEvent;
    FOnCollapsed: TccExpandedEvent;
    FOnCollapsing: TccCollapsingEvent;
    FOnChanging: TccChangingEvent;
    FOnChange: TccChangedEvent;
    FOnCompare: TccCompareEvent;
    FOnDeletion: TccExpandedEvent;
    FOnInsert: TccExpandedEvent;
    FOnGetImageIndex: TccExpandedEvent;
    FOnGetSelectedIndex: TccExpandedEvent;
    FCDFont: TFont;
    FInfoSpace: integer;
    FInfoColor: TColor;
    FTrackSelect: boolean;
    FFullRowSelect: boolean;
    FSingleExpand: boolean;
    FShowInfoTip: boolean;
    FNoToolTips: boolean;
    FShowCheckBoxes: boolean;
    FIntTimerNode: TccTreeNode;
    FPrevScrollNode: TccTreeNode;
    FSclDest: TccScrollDest;
    FIntTimer: TTimer;
    FIntSclTimer: TTimer;
    FDragSource: TDragObject;
    FInOnTimer: boolean;
    FOnCustomDraw: TccTreeViewCustomDraw;
    FOnInfoCustomDraw: TccTreeViewCustomDraw;
    FCBDragNode: TccTreeNode;
    FOnInfoTip: TccTVInfoTip;
    FShowInfoText: boolean;
    FOnCheckChanged: TccCheckChangedEvent;
    FOnCheckChanging: TccCheckChangingEvent;
    FSearchTreeViewEvent: TccSearchTreeViewEvent;

    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMDrag(var Message: TCMDrag); message CM_DRAG;
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
    procedure EditWndProc(var Message: TMessage);
    procedure DoDragOver(Source: TDragObject; X, Y: Integer; CanDrop: Boolean);
    procedure GetImageIndex(Node: TccTreeNode);
    procedure GetSelectedIndex(Node: TccTreeNode);
    function GetDropTarget: TccTreeNode;
    function GetIndent: Integer;
    function GetNodeFromItem(const Item: TTVItem): TccTreeNode;
    function GetSelection: TccTreeNode;
    function GetTopItem: TccTreeNode;
    procedure ImageListChange(Sender: TObject);
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetButtonStyle(Value: Boolean);
    procedure SetDropTarget(Value: TccTreeNode);
    procedure SetHideSelection(Value: Boolean);
    procedure SetImageList(Value: HImageList; Flags: Integer);
    procedure SetIndent(Value: Integer);
    procedure SetImages(Value: TImageList);
    procedure SetLineStyle(Value: Boolean);
    procedure SetReadOnly(Value: Boolean);
    procedure SetRootStyle(Value: Boolean);
    procedure SetSelection(Value: TccTreeNode);
    procedure SetSortType(Value: TccSortType);
    procedure SetStateImages(Value: TImageList);
    procedure SetStyle(Value: Integer; UseStyle: Boolean);
    procedure SeTccTreeNodes(Value: TccTreeNodes);
    procedure SetTopItem(Value: TccTreeNode);
    procedure SetTrackSelectStyle(Value: Boolean);
    procedure SetFullRowSelectStyle(Value: Boolean);
    procedure SetSingleExpandStyle(Value: Boolean);
    procedure SetShowInfoTip(Value: Boolean);
    procedure SetNoToolTips(Value: Boolean);
    procedure SetShowCheckBoxes(Value: Boolean);
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    procedure WMNotify(var Message: TWMNotify); message WM_NOTIFY;
    procedure TVMSetItem(var Message: TMessage); message TVM_SETITEM;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure SetInfoSpace(Value: Integer);
    procedure SetInfoColor(Value: TColor);
    procedure OnTimer(Sender: TObject);
    procedure OnSclTimer(Sender: TObject);
    procedure SetExpandTimer(Node: TccTreeNode);
    procedure SetScrollTimer(Start: boolean; Dest: TccScrollDest);
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure SetInfoTip(Show: boolean);
    procedure SetShowInfoText(Value: boolean);
    procedure GetEditControl(var Message: TMessage); message TVM_GETEDITCONTROL;
  protected
    procedure DoCustomDraw(TreeNode : TccTreeNode; AFont : TFont;
               Var AColor, ABkColor : TColor); virtual;
    procedure DoInfoCustomDraw(TreeNode : TccTreeNode; AFont : TFont;
               Var AColor, ABkColor : TColor); virtual;
    function CanEdit(Node: TccTreeNode): Boolean; dynamic;
    function CanChange(Node: TccTreeNode): Boolean; dynamic;
    function CanCollapse(Node: TccTreeNode): Boolean; dynamic;
    function CanExpand(Node: TccTreeNode): Boolean; dynamic;
    procedure Change(Node: TccTreeNode); dynamic;
    procedure Collapse(Node: TccTreeNode); dynamic;
    function CreateNode: TccTreeNode; virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure DoEndDrag(Target: TObject; X, Y: Integer); override;
    procedure DoStartDrag(var DragObject: TDragObject); override;
    procedure Edit(const Item: TTVItem); dynamic;
    procedure Expand(Node: TccTreeNode); dynamic;
    function GetDragImages: TDragImageList; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetDragMode(Value: TDragMode); override;
    procedure WndProc(var Message: TMessage); override;
    property OnEditing: TccEditingEvent read FOnEditing write FOnEditing;
    property OnEdited: TccEditedEvent read FOnEdited write FOnEdited;
    property OnExpanding: TccExpandingEvent read FOnExpanding write FOnExpanding;
    property OnExpanded: TccExpandedEvent read FOnExpanded write FOnExpanded;
    property OnCollapsing: TccCollapsingEvent read FOnCollapsing write FOnCollapsing;
    property OnCollapsed: TccExpandedEvent read FOnCollapsed write FOnCollapsed;
    property OnChanging: TccChangingEvent read FOnChanging write FOnChanging;
    property OnChange: TccChangedEvent read FOnChange write FOnChange;
    property OnCompare: TccCompareEvent read FOnCompare write FOnCompare;
    property OnDeletion: TccExpandedEvent read FOnDeletion write FOnDeletion;
    property OnInsert: TccExpandedEvent read FOnInsert write FOnInsert;
    property OnGetImageIndex: TccExpandedEvent read FOnGetImageIndex write FOnGetImageIndex;
    property OnGetSelectedIndex: TccExpandedEvent read FOnGetSelectedIndex write FOnGetSelectedIndex;
    property ShowButtons: Boolean read FShowButtons write SetButtonStyle default True;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property ShowLines: Boolean read FShowLines write SetLineStyle default True;
    property ShowRoot: Boolean read FShowRoot write SetRootStyle default True;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly default False;
    property RightClickSelect: Boolean read FRightClickSelect write FRightClickSelect default False;
    property Indent: Integer read GetIndent write SetIndent;
    property Items: TccTreeNodes read FTreeNodes write SeTccTreeNodes;
    property SortType: TccSortType read FSortType write SetSortType default stNone;
    property HideSelection: Boolean read FHideSelection write SetHideSelection default True;
    property Images: TImageList read FImages write SetImages;
    property StateImages: TImageList read FStateImages write SetStateImages;
    property InfoSpace: integer read FInfoSpace write SetInfoSpace default 5;
    property InfoColor: TColor read FInfoColor write SetInfoColor default clBlue;
    property TrackSelect: boolean read FTrackSelect write SetTrackSelectStyle default False;
    property FullRowSelect: boolean read FFullRowSelect write SetFullRowSelectStyle default False;
    property SingleExpand: boolean read FSingleExpand write SetSingleExpandStyle default False;
    property ShowInfoTip: boolean read FShowInfoTip write SetShowInfoTip default False;
    property NoToolTips: boolean read FNoToolTips write SetNoToolTips default False;
    property ShowCheckBoxes: boolean read FShowCheckBoxes write SetShowCheckBoxes default False;
    property OnCustomDraw: TccTreeViewCustomDraw read FOnCustomDraw write FOnCustomDraw;
    property OnInfoCustomDraw: TccTreeViewCustomDraw read FOnInfoCustomDraw write FOnInfoCustomDraw;
    property OnInfoTip: TccTVInfoTip read FOnInfoTip write FOnInfoTip;
    property OnCheckChanged: TccCheckChangedEvent read FOnCheckChanged write FOnCheckChanged;
    property OnCheckChanging: TccCheckChangingEvent read FOnCheckChanging write FOnCheckChanging;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function IsCustomDraw: Boolean; virtual;
    function IsInfoCustomDraw: Boolean; virtual;
    function AlphaSort: Boolean;
    function CustomSort(SortProc: TTVCompare; Data: Longint): Boolean;
    procedure FullCollapse;
    procedure FullExpand;
    function GetHitTestInfoAt(X, Y: Integer): TccHitTests;
    function GetNodeAt(X, Y: Integer): TccTreeNode;
    function IsEditing: Boolean;
    function GetFirstVisible: TccTreeNode;
    function GetLastVisible: TccTreeNode;
    procedure LoadFromFile(const FileName: string);
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToFile(const FileName: string);
    procedure SaveToStream(Stream: TStream);
    procedure RedrawNode(Node: TccTreeNode);
    property DropTarget: TccTreeNode read GetDropTarget write SetDropTarget;
    property Selected: TccTreeNode read GetSelection write SetSelection;
    property TopItem: TccTreeNode read GetTopItem write SetTopItem;
    property ShowInfoText: boolean read FShowInfoText write SetShowInfoText default True;
    property SearchTreeViewEvent: TccSearchTreeViewEvent read FSearchTreeViewEvent write FSearchTreeViewEvent;
    procedure LockUpdate;
    procedure UnLockUpdate;
  end;

{ TccTreeView }

  TccTreeView = class(TccCustomTreeView)
  published
    property ShowButtons;
    property BorderStyle;
    property DragCursor;
    property ShowLines;
    property ShowRoot;
    property ReadOnly;
    property RightClickSelect;
    property DragMode;
    property HideSelection;
    property Indent;
    property Items;
    property OnEditing;
    property OnEdited;
    property OnExpanding;
    property OnExpanded;
    property OnCollapsing;
    property OnCompare;
    property OnCollapsed;
    property OnChanging;
    property OnChange;
    property OnDeletion;
    property OnInsert;
    property OnGetImageIndex;
    property OnGetSelectedIndex;
    property Align;
    property Enabled;
    property Color;
    property ParentColor default False;
    property ParentCtl3D;
    property Ctl3D;
    property SortType;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
    property OnEnter;
    property OnExit;
    property OnDragDrop;
    property OnDragOver;
    property OnStartDrag;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property PopupMenu;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property Images;
    property StateImages;
    property Font;
    property InfoSpace;
    property InfoColor;
    property TrackSelect;
    property FullRowSelect;
    property SingleExpand;
    property ShowInfoTip;
    property NoToolTips;
    property ShowCheckBoxes;
    property OnCustomDraw;
    property OnInfoCustomDraw;
    property OnInfoTip;
    property ShowInfoText;
    property Anchors;
    property OnCheckChanged;
    property OnCheckChanging;
    property SearchTreeViewEvent;
  end;

function GetComCtlVersion: Integer;

implementation

uses Printers, Consts, ComStrs;

const
  {Custom draw constants}
  NM_CUSTOMDRAW   = NM_FIRST-12;
  CDDS_PREPAINT   = $00000001;
  CDDS_POSTPAINT  = $00000002;
  CDDS_PREERASE   = $00000003;
  CDDS_POSTERASE  = $00000004;
  CDDS_ITEM       = $00010000;

  CDDS_ITEMPREPAINT  = CDDS_ITEM Or CDDS_PREPAINT;
  CDDS_ITEMPOSTPAINT = CDDS_ITEM Or CDDS_POSTPAINT;
  CDDS_ITEMPREERASE  = CDDS_ITEM Or CDDS_PREERASE;
  CDDS_ITEMPOSTERASE = CDDS_ITEM Or CDDS_POSTERASE;

  CDRF_DODEFAULT       = $00000000;
  CDRF_NEWFONT         = $00000002;
  CDRF_SKIPDEFAULT     = $00000004;
  CDRF_NOTIFYPOSTPAINT = $00000010;
  CDRF_NOTIFYITEMDRAW  = $00000020;
  CDRF_NOTIFYPOSTERASE = $00000040;
  CDRF_NOTIFYITEMERASE = $00000080;

  ComCtlVersionIE3 = $00040046;
  ComCtlVersionIE4 = $00040047;
  ComCtlVersionIE401 = $00040048;
  ComCtlDllName = 'comctl32.dll';

  TVS_HASBUTTONS          = $0001;
  TVS_HASLINES            = $0002;
  TVS_LINESATROOT         = $0004;
  TVS_EDITLABELS          = $0008;
  TVS_DISABLEDRAGDROP     = $0010;
  TVS_SHOWSELALWAYS       = $0020;
  TVS_RTLREADING          = $0040;
  TVS_NOTOOLTIPS          = $0080;
  TVS_CHECKBOXES          = $0100;
  TVS_TRACKSELECT         = $0200;
  TVS_SINGLEEXPAND        = $0400;
  TVS_INFOTIP             = $0800;
  TVS_FULLROWSELECT       = $1000;
  TVS_NOSCROLL            = $2000;
  TVS_NONEVENHEIGHT       = $4000;

  TVGN_ROOT               = $0000;
  TVGN_NEXT               = $0001;
  TVGN_PREVIOUS           = $0002;
  TVGN_PARENT             = $0003;
  TVGN_CHILD              = $0004;
  TVGN_FIRSTVISIBLE       = $0005;
  TVGN_NEXTVISIBLE        = $0006;
  TVGN_PREVIOUSVISIBLE    = $0007;
  TVGN_DROPHILITE         = $0008;
  TVGN_CARET              = $0009;
  TVGN_LASTVISIBLE        = $000A;

  TVM_GETITEMHEIGHT       = TV_FIRST + 28;
  TVN_GETINFOTIP          = TVN_FIRST-13;
  TVM_GETTOOLTIPS         = TV_FIRST + 25;

  TTM_POP                 = WM_USER + 28;

  CDIS_SELECTED       = $0001;
  CDIS_GRAYED         = $0002;
  CDIS_DISABLED       = $0004;
  CDIS_CHECKED        = $0008;
  CDIS_FOCUS          = $0010;
  CDIS_DEFAULT        = $0020;
  CDIS_HOT            = $0040;
  CDIS_MARKED         = $0080;
  CDIS_INDETERMINATE  = $0100;

  ATreeErrMessage = 'List index out of bounds (%d)';

type
  TNMCustomDraw = record
    hdr : TNMHDR;
    dwDrawStage : DWORD; 
    hdc : HDC;
    rc : TRECT;
    dwItemSpec : DWORD;
    uItemState : UINT;
    LItemlParam : LPARAM;
  end;

  PNMCustomDraw = ^TNMCustomDraw;

  TNMLVCustomDraw = record
    nmcd : TNMCustomDraw;
    clrText : COLORREF;
    clrTextBk : COLORREF;
  end;

  PNMLVCustomDraw = ^TNMLVCustomDraw;

  TSeNMTVGETINFOTIP = packed record
    hdr: TNMHdr;
    pszText: PAnsiChar;
    cchTextMax: Integer;
    hItem: HTREEITEM;
    lParam: LPARAM;
  end;

  PTSeNMTVGETINFOTIP = ^TSeNMTVGETINFOTIP;

var
  ComCtlVersion: Integer = 0;

{ CommCtrls}

function GetComCtlVersion: Integer;
var
  FileName: string;
  InfoSize, Wnd: DWORD;
  VerBuf: Pointer;
  FI: PVSFixedFileInfo;
  VerSize: DWORD;
begin
  if ComCtlVersion = 0 then begin
    FileName := ComCtlDllName;
    InfoSize := GetFileVersionInfoSize(PChar(FileName), Wnd);
    if InfoSize <> 0 then begin
      GetMem(VerBuf, InfoSize);
      try
        if GetFileVersionInfo(PChar(FileName), Wnd, InfoSize, VerBuf) then
          if VerQueryValue(VerBuf, '\', Pointer(FI), VerSize) then
            ComCtlVersion := FI.dwFileVersionMS;
      finally
        FreeMem(VerBuf);
      end;
    end;
  end;
  Result := ComCtlVersion;
end;

function TreeView_SetCheckState(hwndTreeView: HWND; hItem: HTREEITEM; fCheck: BOOL): BOOL;
var
  tvItem: TTVITEM;
begin
  tvItem.mask := TVIF_HANDLE or TVIF_STATE;
  tvItem.hItem := hItem;
  tvItem.stateMask := TVIS_STATEIMAGEMASK;

  if fCheck then
    tvItem.state := INDEXTOSTATEIMAGEMASK(2) else
    tvItem.state := INDEXTOSTATEIMAGEMASK(1);

  Result := TreeView_SetItem(hwndTreeView, tvItem);
end;

function TreeView_GetCheckState(hwndTreeView: HWND; hItem: HTREEITEM): BOOL;
var
  tvItem: TTVITEM;
begin
  tvItem.mask := TVIF_HANDLE or TVIF_STATE;
  tvItem.hItem := hItem;
  tvItem.stateMask := TVIS_STATEIMAGEMASK;

  TreeView_GetItem(hwndTreeView, tvItem);

  Result := BOOL((tvItem.state shr 12) - 1);
end;

procedure SetComCtlStyle(Ctl: TWinControl; Value: Integer; UseStyle: boolean);
var
  Style: Integer;
begin
  if Ctl.HandleAllocated then
  begin
    Style:= GetWindowLong(Ctl.Handle, GWL_STYLE);
    if not UseStyle
      then Style:= Style and not Value
      else Style:= Style or Value;
    SetWindowLong(Ctl.Handle, GWL_STYLE, Style);
  end;
end;

{ TccTreeNode }

function DefaultTreeViewSort(Node1, Node2: TccTreeNode; lParam: Integer): Integer; stdcall;
begin
  with Node1 do
    if Assigned(TreeView.OnCompare) then
      TreeView.OnCompare(TreeView, Node1, Node2, lParam, Result)
    else Result := lstrcmp(PChar(Pointer(Node1.Text)), PChar(Pointer(Node2.Text)));
end;

procedure TreeViewError(const Msg: string);
begin
  raise ETreeViewError.Create(Msg);
end;

procedure TreeViewErrorFmt(const Msg: string; Format: array of const);
begin
  raise ETreeViewError.CreateFmt(Msg, Format);
end;

constructor TccTreeNode.Create(AOwner: TccTreeNodes);
begin
  inherited Create;
  FOverlayIndex := -1;
  FStateIndex := -1;
  FOwner := AOwner;
  FBold := False;
end;

destructor TccTreeNode.Destroy;
var
  Node: TccTreeNode;
  CheckValue: Integer;
begin
  FDeleting := True;
  if Owner.Owner.FLastDropTarget = Self then
    Owner.Owner.FLastDropTarget := nil;
  Node := Parent;
  if (Node <> nil) and (not Node.Deleting) then
  begin
    if Node.IndexOf(Self) <> -1 then CheckValue := 1
    else CheckValue := 0;
    if Node.CompareCount(CheckValue) then
    begin
      Expanded := False;
      Node.HasChildren := False;
    end;
  end;
  if ItemId <> nil then TreeView_DeleteItem(Handle, ItemId);
  Data := nil;
  inherited Destroy;
end;

function TccTreeNode.GetHandle: HWND;
begin
  Result := TreeView.Handle;
end;

function TccTreeNode.GetTreeView: TccCustomTreeView;
begin
  Result := Owner.Owner;
end;

function TccTreeNode.HasAsParent(Value: TccTreeNode): Boolean;
begin
  if Value <> Nil then
  begin
    if Parent = Nil then Result := False
    else if Parent = Value then Result := True
    else Result := Parent.HasAsParent(Value);
  end
  else Result := True;
end;

procedure TccTreeNode.SetText(const S: string);
var
  Item: TTVItem;
begin
  FText := S;
  with Item do
  begin
    mask := TVIF_TEXT;
    hItem := ItemId;
    pszText := LPSTR_TEXTCALLBACK;
  end;
  TreeView_SetItem(Handle, Item);
  if (TreeView.SortType in [stText, stBoth]) and FInTree then
  begin
    if (Parent <> nil) then Parent.AlphaSort
    else TreeView.AlphaSort;
  end;
end;

procedure TccTreeNode.SetInfoText(const S: string);
var
  Item: TTVItem;
begin
  FInfoText := S;
  with Item do
  begin
    mask := TVIF_TEXT;
    hItem := ItemId;
    pszText := LPSTR_TEXTCALLBACK;
  end;
  TreeView_SetItem(Handle, Item);
end;

procedure TccTreeNode.SetData(Value: Pointer);
begin
  FData := Value;
  if (TreeView.SortType in [stData, stBoth]) and Assigned(TreeView.OnCompare)
    and (not Deleting) and FInTree then
  begin
    if Parent <> nil then Parent.AlphaSort
    else TreeView.AlphaSort;
  end;
end;

function TccTreeNode.GetState(NodeState: TccNodeState): Boolean;
var
  Item: TTVItem;
begin
  Result := False;
  with Item do
  begin
    mask := TVIF_STATE;
    hItem := ItemId;
    if TreeView_GetItem(Handle, Item) then
      case NodeState of
        nsCut: Result := (state and TVIS_CUT) <> 0;
        nsFocused: Result := (state and TVIS_FOCUSED) <> 0;
        nsSelected: Result := (state and TVIS_SELECTED) <> 0;
        nsExpanded: Result := (state and TVIS_EXPANDED) <> 0;
        nsDropHilited: Result := (state and TVIS_DROPHILITED) <> 0;
        nsBold: Result := (state and TVIS_BOLD) <> 0;
        nsExpandedOnce: Result := (state and TVIS_EXPANDEDONCE) <> 0;
        nsExpandPartial: Result := (state and TVIS_EXPANDPARTIAL) <> 0;
      end;
  end;
end;

procedure TccTreeNode.SetImageIndex(Value: Integer);
var
  Item: TTVItem;
begin
  FImageIndex := Value;
  with Item do
  begin
    mask := TVIF_IMAGE or TVIF_HANDLE;
    hItem := ItemId;
    iImage := I_IMAGECALLBACK;
  end;
  TreeView_SetItem(Handle, Item);
end;

procedure TccTreeNode.SetBold(Value: Boolean);
var
  Item: TTVItem;
begin
  FBold := Value;
  FillChar(Item, SizeOf(Item), 0);
  with Item do begin
    mask := TVIF_STATE or TVIF_HANDLE;
    StateMask := TVIS_BOLD;
    if FBold then State := TVIS_BOLD;
    hItem := ItemId;
  end;
  TreeView_SetItem(Handle, Item);
end;

procedure TccTreeNode.SetSelectedIndex(Value: Integer);
var
  Item: TTVItem;
begin
  FSelectedIndex := Value;
  with Item do
  begin
    mask := TVIF_SELECTEDIMAGE or TVIF_HANDLE;
    hItem := ItemId;
    iSelectedImage := I_IMAGECALLBACK;
  end;
  TreeView_SetItem(Handle, Item);
end;

procedure TccTreeNode.SetOverlayIndex(Value: Integer);
var
  Item: TTVItem;
begin
  FOverlayIndex := Value;
  with Item do
  begin
    mask := TVIF_STATE or TVIF_HANDLE;
    stateMask := TVIS_OVERLAYMASK;
    hItem := ItemId;
    state := IndexToOverlayMask(OverlayIndex + 1);
  end;
  TreeView_SetItem(Handle, Item);
end;

procedure TccTreeNode.SetStateIndex(Value: Integer);
var
  Item: TTVItem;
begin
  FStateIndex := Value;
  if Value >= 0 then Dec(Value);
  with Item do
  begin
    mask := TVIF_STATE or TVIF_HANDLE;
    stateMask := TVIS_STATEIMAGEMASK;
    hItem := ItemId;
    state := IndexToStateImageMask(Value + 1);
  end;
  TreeView_SetItem(Handle, Item);
end;

function TccTreeNode.GetChecked: Boolean;
begin
  Result := TreeView_GetCheckState(Handle, ItemId);
end;

procedure TccTreeNode.SetChecked(Value: Boolean);
begin
  TreeView_SetCheckState(Handle, ItemId, Value);
end;

function TccTreeNode.CompareCount(CompareMe: Integer): Boolean;
var
  Count: integer;
  Node: TccTreeNode;
Begin
  Count := 0;
  Result := False;
  Node := GetFirstChild;
  while Node <> nil do
  begin
    Inc(Count);
    Node := Node.GetNextChild(Node);
    if Count > CompareMe then Exit;
  end;
  if Count = CompareMe then Result := True;
end;

function TccTreeNode.DoCanExpand(Expand: Boolean): Boolean;
begin
  Result := False;
  if HasChildren then
  begin
    if Expand then Result := TreeView.CanExpand(Self)
    else Result := TreeView.CanCollapse(Self);
  end;
end;

procedure TccTreeNode.DoExpand(Expand: Boolean);
begin
  if HasChildren then
  begin
    if Expand then TreeView.Expand(Self)
    else TreeView.Collapse(Self);
  end;
end;

procedure TccTreeNode.ExpandItem(Expand: Boolean; Recurse: Boolean);
var
  Flag: Integer;
  Node: TccTreeNode;
begin
  if Recurse then
  begin
    Node := Self;
    repeat
      Node.ExpandItem(Expand, False);
      Node := Node.GetNext;
    until (Node = nil) or (not Node.HasAsParent(Self));
  end
  else begin
    TreeView.FManualNotify := True;
    try
      Flag := 0;
      if Expand then
      begin
        if DoCanExpand(True) then
        begin
          Flag := TVE_EXPAND;
          DoExpand(True);
        end;
      end
      else begin
        if DoCanExpand(False) then
        begin
          Flag := TVE_COLLAPSE;
          DoExpand(False);
        end;
      end;
      if Flag <> 0 then TreeView_Expand(Handle, ItemId, Flag);
    finally
      TreeView.FManualNotify := False;
    end;
  end;
end;

procedure TccTreeNode.Expand(Recurse: Boolean);
begin
  ExpandItem(True, Recurse);
end;

procedure TccTreeNode.Collapse(Recurse: Boolean);
begin
  ExpandItem(False, Recurse);
end;

function TccTreeNode.GetExpanded: Boolean;
begin
  Result := GetState(nsExpanded);
end;

procedure TccTreeNode.SetExpanded(Value: Boolean);
begin
  if Value then Expand(False)
  else Collapse(False);
end;

function TccTreeNode.GetSelected: Boolean;
begin
  Result := GetState(nsSelected);
end;

procedure TccTreeNode.SetSelected(Value: Boolean);
begin
  if Value then TreeView_SelectItem(Handle, ItemId)
  else if Selected then TreeView_SelectItem(Handle, nil);
end;

function TccTreeNode.GetCut: Boolean;
begin
  Result := GetState(nsCut);
end;

procedure TccTreeNode.SetCut(Value: Boolean);
var
  Item: TTVItem;
  Template: Integer;
begin
  if Value then Template := -1
  else Template := 0;
  with Item do
  begin
    mask := TVIF_STATE;
    hItem := ItemId;
    stateMask := TVIS_CUT;
    state := stateMask and Template;
  end;
  TreeView_SetItem(Handle, Item);
end;

function TccTreeNode.GetDropTarget: Boolean;
begin
  Result := GetState(nsDropHilited);
end;

procedure TccTreeNode.SetDropTarget(Value: Boolean);
begin
  if Value then TreeView_SelectDropTarget(Handle, ItemId)
  else if DropTarget then TreeView_SelectDropTarget(Handle, nil);
end;

function TccTreeNode.GetChildren: Boolean;
var
  Item: TTVItem;
begin
  Item.mask := TVIF_CHILDREN;
  Item.hItem := ItemId;
  if TreeView_GetItem(Handle, Item) then Result := Item.cChildren > 0
  else Result := False;
end;

procedure TccTreeNode.SetFocused(Value: Boolean);
var
  Item: TTVItem;
  Template: Integer;
begin
  if Value then Template := -1
  else Template := 0;
  with Item do
  begin
    mask := TVIF_STATE;
    hItem := ItemId;
    stateMask := TVIS_FOCUSED;
    state := stateMask and Template;
  end;
  TreeView_SetItem(Handle, Item);
end;

function TccTreeNode.GetFocused: Boolean;
begin
  Result := GetState(nsFocused);
end;

procedure TccTreeNode.SetChildren(Value: Boolean);
var
  Item: TTVItem;
begin
  with Item do
  begin
    mask := TVIF_CHILDREN;
    hItem := ItemId;
    cChildren := Ord(Value);
  end;
  TreeView_SetItem(Handle, Item);
end;

function TccTreeNode.GetParent: TccTreeNode;
begin
  with FOwner do
    Result := GetNode(TreeView_GetParent(Handle, ItemId));
end;

function TccTreeNode.GetNextSibling: TccTreeNode;
begin
  with FOwner do
    Result := GetNode(TreeView_GetNextSibling(Handle, ItemId));
end;

function TccTreeNode.GetPrevSibling: TccTreeNode;
begin
  with FOwner do
    Result := GetNode(TreeView_GetPrevSibling(Handle, ItemId));
end;

function TccTreeNode.GetNextVisible: TccTreeNode;
begin
  if IsVisible then
    with FOwner do
      Result := GetNode(TreeView_GetNextVisible(Handle, ItemId))
  else Result := nil;
end;

function TccTreeNode.GetPrevVisible: TccTreeNode;
begin
  with FOwner do
    Result := GetNode(TreeView_GetPrevVisible(Handle, ItemId));
end;

function TccTreeNode.GetNextChild(Value: TccTreeNode): TccTreeNode;
begin
  if Value <> nil then Result := Value.GetNextSibling
  else Result := nil;
end;

function TccTreeNode.GetPrevChild(Value: TccTreeNode): TccTreeNode;
begin
  if Value <> nil then Result := Value.GetPrevSibling
  else Result := nil;
end;

function TccTreeNode.GetFirstChild: TccTreeNode;
begin
  with FOwner do
    Result := GetNode(TreeView_GetChild(Handle, ItemId));
end;

function TccTreeNode.GetLastChild: TccTreeNode;
var
  Node: TccTreeNode;
begin
  Result := GetFirstChild;
  if Result <> nil then
  begin
    Node := Result;
    repeat
      Result := Node;
      Node := Result.GetNextSibling;
    until Node = nil;
  end;
end;

function TccTreeNode.GetNext: TccTreeNode;
var
  NodeID, ParentID: HTreeItem;
  Handle: HWND;
begin
  Handle := FOwner.Handle;
  NodeID := TreeView_GetChild(Handle, ItemId);
  if NodeID = nil then NodeID := TreeView_GetNextSibling(Handle, ItemId);
  ParentID := ItemId;
  while (NodeID = nil) and (ParentID <> nil) do
  begin
    ParentID := TreeView_GetParent(Handle, ParentID);
    NodeID := TreeView_GetNextSibling(Handle, ParentID);
  end;
  Result := FOwner.GetNode(NodeID);
end;

function TccTreeNode.GetPrev: TccTreeNode;
var
  Node: TccTreeNode;
begin
  Result := GetPrevSibling;
  if Result <> nil then
  begin
    Node := Result;
    repeat
      Result := Node;
      Node := Result.GetLastChild;
    until Node = nil;
  end else
    Result := Parent;
end;

function TccTreeNode.GetAbsoluteIndex: Integer;
var
  Node: TccTreeNode;
begin
  Result := -1;
  Node := Self;
  while Node <> nil do
  begin
    Inc(Result);
    Node := Node.GetPrev;
  end;
end;

function TccTreeNode.GetIndex: Integer;
var
  Node: TccTreeNode;
begin
  Result := -1;
  Node := Self;
  while Node <> nil do
  begin
    Inc(Result);
    Node := Node.GetPrevSibling;
  end;
end;

function TccTreeNode.GetItem(Index: Integer): TccTreeNode;
begin
  Result := GetFirstChild;
  while (Result <> nil) and (Index > 0) do
  begin
    Result := GetNextChild(Result);
    Dec(Index);
  end;
  if Result = nil then TreeViewError(ATreeErrMessage);
end;

procedure TccTreeNode.SetItem(Index: Integer; Value: TccTreeNode);
begin
  item[Index].Assign(Value);
end;

function TccTreeNode.IndexOf(Value: TccTreeNode): Integer;
var
  Node: TccTreeNode;
begin
  Result := -1;
  Node := GetFirstChild;
  while (Node <> nil) do
  begin
    Inc(Result);
    if Node = Value then Break;
    Node := GetNextChild(Node);
  end;
  if Node = nil then Result := -1;
end;

function TccTreeNode.GetCount: Integer;
var
  Node: TccTreeNode;
begin
  Result := 0;
  Node := GetFirstChild;
  while Node <> nil do
  begin
    Inc(Result);
    Node := Node.GetNextChild(Node);
  end;
end;

procedure TccTreeNode.EndEdit(Cancel: Boolean);
begin
  TreeView_EndEditLabelNow(Handle, Cancel);
end;

procedure TccTreeNode.InternalMove(ParentNode, Node: TccTreeNode;
  HItem: HTreeItem; AddMode: TccAddMode);
var
  I: Integer;
  NodeId: HTreeItem;
  TreeViewItem: TTVItem;
  Children: Boolean;
  IsSelected: Boolean;
begin
  if (AddMode = taInsert) and (Node <> nil) then
    NodeId := Node.ItemId else
    NodeId := nil;
  Children := HasChildren;
  IsSelected := Selected;
  if (Parent <> nil) and (Parent.CompareCount(1)) then
  begin
    Parent.Expanded := False;
    Parent.HasChildren := False;
  end;
  with TreeViewItem do
  begin
    mask := TVIF_PARAM;
    hItem := ItemId;
    lParam := 0;
  end;
  TreeView_SetItem(Handle, TreeViewItem);
  with Owner do
    HItem := AddItem(HItem, NodeId, CreateItem(Self), AddMode);
  if HItem = nil then
    raise EOutOfResources.Create(sInsertError);
  for I := Count - 1 downto 0 do
    Item[I].InternalMove(Self, nil, HItem, taAddFirst);
  TreeView_DeleteItem(Handle, ItemId);
  FItemId := HItem;
  Assign(Self);
  HasChildren := Children;
  Selected := IsSelected;
end;

procedure TccTreeNode.MoveTo(Destination: TccTreeNode; Mode: TccNodeAttachMode);
var
  AddMode: TccAddMode;
  Node: TccTreeNode;
  HItem: HTreeItem;
  OldOnChanging: TccChangingEvent;
  OldOnChange: TccChangedEvent;
begin
  OldOnChanging := TreeView.OnChanging;
  OldOnChange := TreeView.OnChange;
  TreeView.OnChanging := nil;
  TreeView.OnChange := nil;
  try
    if (Destination = nil) or not Destination.HasAsParent(Self) then
    begin
      AddMode := taAdd;
      if (Destination <> nil) and not (Mode in [naAddChild, naAddChildFirst]) then
        Node := Destination.Parent else
        Node := Destination;
      case Mode of
        naAdd,
        naAddChild: AddMode := taAdd;
        naAddFirst,
        naAddChildFirst: AddMode := taAddFirst;
        naInsert:
          begin
            Destination := Destination.GetPrevSibling;
            if Destination = nil then AddMode := taAddFirst
            else AddMode := taInsert;
          end;
      end;
      if Node <> nil then
        HItem := Node.ItemId else
        HItem := nil;
      InternalMove(Node, Destination, HItem, AddMode);
      Node := Parent;
      if Node <> nil then
      begin
        Node.HasChildren := True;
        Node.Expanded := True;
      end;
    end;
  finally
    TreeView.OnChanging := OldOnChanging;
    TreeView.OnChange := OldOnChange;
  end;
end;

function TccTreeNode.GetExpandedOnce: boolean;
begin
  result := GetState(nsExpandedOnce);
end;

procedure TccTreeNode.SetExpandedOnce(Value: boolean);
var
  tvi  : TTVItem;
begin
  FillChar(tvi, Sizeof(tvi), 0);
  tvi.hItem := ItemID;
  tvi.mask := TVIF_STATE;
  tvi.stateMask := TVIS_EXPANDEDONCE;
  if Value then tvi.state := TVIS_EXPANDEDONCE;
  TreeView_SetItem(Handle, tvi);
end;

function TccTreeNode.GetExpandPartial: boolean;
begin
  result := GetState(nsExpandPartial);
end;

procedure TccTreeNode.SetExpandPartial(Value: boolean);
var
  tvi  : TTVItem;
begin
  FillChar(tvi, Sizeof(tvi), 0);
  tvi.hItem := ItemID;
  tvi.mask := TVIF_STATE;
  tvi.stateMask := TVIS_EXPANDPARTIAL;
  if Value then tvi.state := TVIS_EXPANDPARTIAL;
  TreeView_SetItem(Handle, tvi);
end;

procedure TccTreeNode.MakeVisible;
begin
  TreeView_EnsureVisible(Handle, ItemId);
end;

function TccTreeNode.GetLevel: Integer;
var
  Node: TccTreeNode;
begin
  Result := 0;
  Node := Parent;
  while Node <> nil do
  begin
    Inc(Result);
    Node := Node.Parent;
  end;
end;

function TccTreeNode.IsNodeVisible: Boolean;
var Rect: TRect;
begin
  Result := TreeView_GetItemRect(Handle, ItemId, Rect, True);
end;

function TccTreeNode.EditText: Boolean;
begin
  Result := TreeView_EditLabel(Handle, ItemId) <> 0;
end;

function TccTreeNode.DisplayRect(TextOnly: Boolean): TRect;
begin
  FillChar(Result, SizeOf(Result), 0);
  TreeView_GetItemRect(Handle, ItemId, Result, TextOnly);
end;

function TccTreeNode.AlphaSort: Boolean;
begin
  Result := CustomSort(nil, 0);
end;

function TccTreeNode.CustomSort(SortProc: TTVCompare; Data: Longint): Boolean;
var
  SortCB: TTVSortCB;
begin
  with SortCB do
  begin
    if not Assigned(SortProc) then lpfnCompare := @DefaultTreeViewSort
    else lpfnCompare := SortProc;
    hParent := ItemId;
    lParam := Data;
  end;
  Result := TreeView_SortChildrenCB(Handle, SortCB, 0);
end;

procedure TccTreeNode.Delete;
begin
  if not Deleting then Free;
end;

procedure TccTreeNode.DeleteChildren;
begin
  TreeView_Expand(TreeView.Handle, ItemID, TVE_COLLAPSE or TVE_COLLAPSERESET);
  HasChildren := False;
end;

procedure TccTreeNode.Assign(Source: TPersistent);
var
  Node: TccTreeNode;
begin
  if Source is TccTreeNode then
  begin
    Node := TccTreeNode(Source);
    Text := Node.Text;
    InfoText := Node.InfoText;
    Bold := Node.Bold;
    Data := Node.Data;
    Checked := Node.Checked;
    ImageIndex := Node.ImageIndex;
    SelectedIndex := Node.SelectedIndex;
    StateIndex := Node.StateIndex;
    OverlayIndex := Node.OverlayIndex;
    Focused := Node.Focused;
    DropTarget := Node.DropTarget;
    Cut := Node.Cut;
    HasChildren := Node.HasChildren;
  end
  else inherited Assign(Source);
end;

function TccTreeNode.IsEqual(Node: TccTreeNode): Boolean;
begin
  Result := (Text = Node.Text) and (Data = Node.Data);
end;

procedure TccTreeNode.ReadData(Stream: TStream; PRec: PTccNodeInfo);
var
  I, Size: Integer;
  str: string;
begin
  Stream.ReadBuffer(PRec^, SizeOf(TccNodeInfo));

  SetLength(str, PRec^.TextLen);
  if PRec^.TextLen <> 0 then Stream.ReadBuffer(str[1], PRec^.TextLen);
  Text := str;

  SetLength(str, PRec^.InfoTextLen);
  if PRec^.InfoTextLen <> 0 then Stream.ReadBuffer(str[1], PRec^.InfoTextLen);
  InfoText := str;

  Bold := PRec^.Bold;
  ImageIndex := PRec^.ImageIndex;
  SelectedIndex := PRec^.SelectedIndex;
  OverlayIndex := PRec^.OverlayIndex;
  StateIndex := PRec^.StateIndex;
  Checked := PRec^.Checked;
  Data := PRec^.Data;

  Size := PRec^.Count;
  for I := 0 to Size - 1 do
    with Owner.AddChild(Self, '') do ReadData(Stream, PRec);
end;

procedure TccTreeNode.WriteData(Stream: TStream; PRec: PTccNodeInfo);
var
  I, Size: Integer;
begin
  PRec^.TextLen := Length(Text);
  PRec^.InfoTextLen := Length(InfoText);
  PRec^.Bold := Bold;
  PRec^.ImageIndex := ImageIndex;
  PRec^.SelectedIndex := SelectedIndex;
  PRec^.OverlayIndex := OverlayIndex;
  PRec^.StateIndex := StateIndex;
  PRec^.Checked := Checked;
  PRec^.Data := Data;
  PRec^.Count := Count;

  Size := Count;

  Stream.WriteBuffer(PRec^, SizeOf(TccNodeInfo));

  if PRec^.TextLen <> 0 then Stream.WriteBuffer(Text[1], PRec^.TextLen);

  if PRec^.InfoTextLen <> 0 then Stream.WriteBuffer(InfoText[1], PRec^.InfoTextLen);

  for I := 0 to Size - 1 do Item[I].WriteData(Stream, PRec);
end;

function TccTreeNode.GetTheText: string;
begin
  result := string(PChar(Text));
end;


{ TccTreeNodes }

constructor TccTreeNodes.Create(AOwner: TccCustomTreeView);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor TccTreeNodes.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TccTreeNodes.GetCount: Integer;
begin
  if Owner.HandleAllocated then Result := TreeView_GetCount(Handle)
  else Result := 0;
end;

function TccTreeNodes.GetHandle: HWND;
begin
  Result := Owner.Handle;
end;

procedure TccTreeNodes.Delete(Node: TccTreeNode);
begin
  if (Node.ItemId = nil) and Assigned(Owner.FOnDeletion) then
    Owner.FOnDeletion(Self, Node);
  Node.Delete;
end;

procedure TccTreeNodes.Clear;
begin
  if Owner.HandleAllocated then
    TreeView_DeleteAllItems(Handle);
end;

function TccTreeNodes.AddChildFirst(Node: TccTreeNode; const S: string): TccTreeNode;
begin
  Result := AddChildObjectFirst(Node, S, nil);
end;

function TccTreeNodes.AddChildObjectFirst(Node: TccTreeNode; const S: string;
  Ptr: Pointer): TccTreeNode;
begin
  Result := InternalAddObject(Node, S, Ptr, taAddFirst);
end;

function TccTreeNodes.AddChild(Node: TccTreeNode; const S: string): TccTreeNode;
begin
  Result := AddChildObject(Node, S, nil);
end;

function TccTreeNodes.AddChildObject(Node: TccTreeNode; const S: string;
  Ptr: Pointer): TccTreeNode;
begin
  Result := InternalAddObject(Node, S, Ptr, taAdd);
end;

function TccTreeNodes.AddFirst(Node: TccTreeNode; const S: string): TccTreeNode;
begin
  Result := AddObjectFirst(Node, S, nil);
end;

function TccTreeNodes.AddObjectFirst(Node: TccTreeNode; const S: string;
  Ptr: Pointer): TccTreeNode;
begin
  if Node <> nil then Node := Node.Parent;
  Result := InternalAddObject(Node, S, Ptr, taAddFirst);
end;

function TccTreeNodes.Add(Node: TccTreeNode; const S: string): TccTreeNode;
begin
  Result := AddObject(Node, S, nil);
end;

procedure TccTreeNodes.Repaint(Node: TccTreeNode);
var
  R: TRect;
begin
  if FUpdateCount < 1 then
  begin
    while (Node <> nil) and not Node.IsVisible do Node := Node.Parent;
    if Node <> nil then
    begin
      R := Node.DisplayRect(False);
      InvalidateRect(Owner.Handle, @R, True);
    end;
  end;
end;

function TccTreeNodes.AddObject(Node: TccTreeNode; const S: string;
  Ptr: Pointer): TccTreeNode;
begin
  if Node <> nil then Node := Node.Parent;
  Result := InternalAddObject(Node, S, Ptr, taAdd);
end;

function TccTreeNodes.Insert(Node: TccTreeNode; const S: string): TccTreeNode;
begin
  Result := InsertObject(Node, S, nil);
end;

procedure TccTreeNodes.AddedNode(Value: TccTreeNode);
begin
  if Value <> nil then
  begin
    Value.HasChildren := True;
    Repaint(Value);
  end;
end;

function TccTreeNodes.InsertObject(Node: TccTreeNode; const S: string;
  Ptr: Pointer): TccTreeNode;
var
  Item, ItemId: HTreeItem;
  Parent: TccTreeNode;
  AddMode: TccAddMode;
begin
  Result := Owner.CreateNode;
  try
    Item := nil;
    ItemId := nil;
    Parent := nil;
    AddMode := taInsert;
    if Node <> nil then
    begin
      Parent := Node.Parent;
      if Parent <> nil then Item := Parent.ItemId;
      Node := Node.GetPrevSibling;
      if Node <> nil then ItemId := Node.ItemId
      else AddMode := taAddFirst;
    end;
    Result.Data := Ptr;
    Result.Text := S;
    Item := AddItem(Item, ItemId, CreateItem(Result), AddMode);
    if Item = nil then
      raise EOutOfResources.Create(sInsertError);
    Result.FItemId := Item;
    AddedNode(Parent);
  except
    Result.Free;
    raise;
  end;
end;

function TccTreeNodes.InternalAddObject(Node: TccTreeNode; const S: string;
  Ptr: Pointer; AddMode: TccAddMode): TccTreeNode;
var
  Item: HTreeItem;
begin
  Result := Owner.CreateNode;
  try
    if Node <> nil then Item := Node.ItemId
    else Item := nil;
    Result.Data := Ptr;
    Result.Text := S;
    Item := AddItem(Item, nil, CreateItem(Result), AddMode);
    if Item = nil then
      raise EOutOfResources.Create(sInsertError);
    Result.FItemId := Item;
    AddedNode(Node);
  except
    Result.Free;
    raise;
  end;
end;

function TccTreeNodes.CreateItem(Node: TccTreeNode): TTVItem;
begin
  Node.FInTree := True;
  with Result do
  begin
    mask := TVIF_TEXT or TVIF_PARAM or TVIF_IMAGE or TVIF_SELECTEDIMAGE;
    lParam := Longint(Node);
    pszText := LPSTR_TEXTCALLBACK;
    iImage := I_IMAGECALLBACK;
    iSelectedImage := I_IMAGECALLBACK;
  end;
end;

function TccTreeNodes.AddItem(Parent, Target: HTreeItem;
  const Item: TTVItem; AddMode: TccAddMode): HTreeItem;
var
  InsertStruct: TTVInsertStruct;
begin
  with InsertStruct do
  begin
    hParent := Parent;
    case AddMode of
      taAddFirst:
        hInsertAfter := TVI_FIRST;
      taAdd:
        hInsertAfter := TVI_LAST;
      taInsert:
        hInsertAfter := Target;
    end;
  end;
  InsertStruct.item := Item;
  Result := TreeView_InsertItem(Handle, InsertStruct);
end;

function TccTreeNodes.GetFirstNode: TccTreeNode;
begin
  Result := GetNode(TreeView_GetRoot(Handle));
end;

function TccTreeNodes.GetNodeFromIndex(Index: Integer): TccTreeNode;
begin
  Result := GetFirstNode;
  while (Index <> 0) and (Result <> nil) do
  begin
    Result := Result.GetNext;
    Dec(Index);
  end;
  if Result = nil then TreeViewError(sInvalidIndex);
end;

function TccTreeNodes.GetNode(ItemId: HTreeItem): TccTreeNode;
var
  Item: TTVItem;
begin
  with Item do
  begin
    hItem := ItemId;
    mask := TVIF_PARAM;
  end;
  if TreeView_GetItem(Handle, Item) then Result := TccTreeNode(Item.lParam)
  else Result := nil;
end;

procedure TccTreeNodes.SetItem(Index: Integer; Value: TccTreeNode);
begin
  GetNodeFromIndex(Index).Assign(Value);
end;

procedure TccTreeNodes.BeginUpdate;
begin
  if FUpdateCount = 0 then SetUpdateState(True);
  Inc(FUpdateCount);
end;

procedure TccTreeNodes.SetUpdateState(Updating: Boolean);
begin
  SendMessage(Handle, WM_SETREDRAW, Ord(not Updating), 0);
  if Updating then Owner.Refresh;
end;

procedure TccTreeNodes.EndUpdate;
begin
  Dec(FUpdateCount);
  if FUpdateCount = 0 then SetUpdateState(False);
end;

procedure TccTreeNodes.Assign(Source: TPersistent);
var
  TreeNodes: TccTreeNodes;
  MemStream: TMemoryStream;
begin
  if Source is TccTreeNodes then
  begin
    TreeNodes := TccTreeNodes(Source);
    Clear;
    MemStream := TMemoryStream.Create;
    try
      TreeNodes.WriteData(MemStream);
      MemStream.Position := 0;
      ReadData(MemStream);
    finally
      MemStream.Free;
    end;
  end
  else inherited Assign(Source);
end;

procedure TccTreeNodes.DefineProperties(Filer: TFiler);

  function WriteNodes: Boolean;
  var
    I: Integer;
    Nodes: TccTreeNodes;
  begin
    Nodes := TccTreeNodes(Filer.Ancestor);
    if Nodes = nil then
      Result := Count > 0
    else if Nodes.Count <> Count then
      Result := True
    else
    begin
      Result := False;
      for I := 0 to Count - 1 do
      begin
        Result := not Item[I].IsEqual(Nodes[I]);
        if Result then Break;
      end
    end;
  end;

begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('Data', ReadData, WriteData, WriteNodes);
end;

procedure TccTreeNodes.ReadData(Stream: TStream);
var
  I, Count: Integer;
  Rec: TccNodeInfo;
begin
  Clear;
  Stream.ReadBuffer(Count, SizeOf(Count));
  for I := 0 to Count - 1 do
    Add(nil, '').ReadData(Stream, @Rec);
end;

procedure TccTreeNodes.WriteData(Stream: TStream);
var
  I: Integer;
  Node: TccTreeNode;
  Rec: TccNodeInfo;
begin
  I := 0;
  Node := GetFirstNode;
  while Node <> nil do
  begin
    Inc(I);
    Node := Node.GetNextSibling;
  end;
  Stream.WriteBuffer(I, SizeOf(I));
  Node := GetFirstNode;
  while Node <> nil do
  begin
    Node.WriteData(Stream, @Rec);
    Node := Node.GetNextSibling;
  end;
end;

type
  TTreeStrings = class(TStrings)
  private
    FOwner: TccTreeNodes;
  protected
    function Get(Index: Integer): string; override;
    function GetBufStart(Buffer: PChar; var Level: Integer): PChar;
    function GetCount: Integer; override;
    function GetObject(Index: Integer): TObject; override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    procedure SetUpdateState(Updating: Boolean); override;
  public
    constructor Create(AOwner: TccTreeNodes);
    function Add(const S: string): Integer; override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: string); override;
    procedure LoadTreeFromStream(Stream: TStream);
    procedure SaveTreeToStream(Stream: TStream);
    property Owner: TccTreeNodes read FOwner;
  end;

constructor TTreeStrings.Create(AOwner: TccTreeNodes);
begin
  inherited Create;
  FOwner := AOwner;
end;

function TTreeStrings.Get(Index: Integer): string;
const
  TabChar = #9;
var
  Level, I: Integer;
  Node: TccTreeNode;
begin
  Result := '';
  Node := Owner.GetNodeFromIndex(Index);
  Level := Node.Level;
  for I := 0 to Level - 1 do Result := Result + TabChar;
  Result := Result + Node.Text;
end;

function TTreeStrings.GetBufStart(Buffer: PChar; var Level: Integer): PChar;
begin
  Level := 0;
  while Buffer^ in [' ', #9] do
  begin
    Inc(Buffer);
    Inc(Level);
  end;
  Result := Buffer;
end;

function TTreeStrings.GetObject(Index: Integer): TObject;
begin
  Result := Owner.GetNodeFromIndex(Index).Data;
end;

procedure TTreeStrings.PutObject(Index: Integer; AObject: TObject);
begin
  Owner.GetNodeFromIndex(Index).Data := AObject;
end;

function TTreeStrings.GetCount: Integer;
begin
  Result := Owner.Count;
end;

procedure TTreeStrings.Clear;
begin
  Owner.Clear;
end;

procedure TTreeStrings.Delete(Index: Integer);
begin
  Owner.GetNodeFromIndex(Index).Delete;
end;

procedure TTreeStrings.SetUpdateState(Updating: Boolean);
begin
  SendMessage(Owner.Handle, WM_SETREDRAW, Ord(not Updating), 0);
  if not Updating then Owner.Owner.Refresh;
end;

function TTreeStrings.Add(const S: string): Integer;
var
  Level, OldLevel, I: Integer;
  NewStr: string;
  Node: TccTreeNode;
begin
  Result := GetCount;
  if (Length(S) = 1) and (S[1] = Chr($1A)) then Exit;
  Node := nil;
  OldLevel := 0;
  NewStr := GetBufStart(PChar(S), Level);
  if Result > 0 then
  begin
    Node := Owner.GetNodeFromIndex(Result - 1);
    OldLevel := Node.Level;
  end;
  if (Level > OldLevel) or (Node = nil) then
  begin
    if Level - OldLevel > 1 then TreeViewError(sInvalidLevel);
  end
  else begin
    for I := OldLevel downto Level do
    begin
      Node := Node.Parent;
      if (Node = nil) and (I - Level > 0) then
        TreeViewError(sInvalidLevel);
    end;
  end;
  Owner.AddChild(Node, NewStr);
end;

procedure TTreeStrings.Insert(Index: Integer; const S: string);
begin
  with Owner do
    Insert(GetNodeFromIndex(Index), S);
end;

procedure TTreeStrings.LoadTreeFromStream(Stream: TStream);
var
  List: TStringList;
  ANode, NextNode: TccTreeNode;
  ALevel, i: Integer;
  CurrStr: string;
begin
  List := TStringList.Create;
  Owner.BeginUpdate;
  try
    try
      Clear;
      List.LoadFromStream(Stream);
      ANode := nil;
      for i := 0 to List.Count - 1 do
      begin
        CurrStr := GetBufStart(PChar(List[i]), ALevel);
        if ANode = nil then
          ANode := Owner.AddChild(nil, CurrStr)
        else if ANode.Level = ALevel then
          ANode := Owner.AddChild(ANode.Parent, CurrStr)
        else if ANode.Level = (ALevel - 1) then
          ANode := Owner.AddChild(ANode, CurrStr)
        else if ANode.Level > ALevel then
        begin
          NextNode := ANode.Parent;
          while NextNode.Level > ALevel do
            NextNode := NextNode.Parent;
          ANode := Owner.AddChild(NextNode.Parent, CurrStr);
        end
        else TreeViewErrorFmt(sInvalidLevelEx, [ALevel, CurrStr]);
      end;
    finally
      Owner.EndUpdate;
      List.Free;
    end;
  except
    Owner.Owner.Invalidate;  
    raise;
  end;
end;

procedure TTreeStrings.SaveTreeToStream(Stream: TStream);
const
  TabChar = #9;
  EndOfLine = #13#10;
var
  i: Integer;
  ANode: TccTreeNode;
  NodeStr: string;
begin
  if Count > 0 then
  begin
    ANode := Owner[0];
    while ANode <> nil do
    begin
      NodeStr := '';
      for i := 0 to ANode.Level - 1 do NodeStr := NodeStr + TabChar;
      NodeStr := NodeStr + ANode.Text + EndOfLine;
      Stream.Write(Pointer(NodeStr)^, Length(NodeStr));
      ANode := ANode.GetNext;
    end;
  end;
end;

{ TccCustomTreeView }

constructor TccCustomTreeView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csCaptureMouse] + [csDisplayDragImage, csReflector];
  Width := 121;
  Height := 97;
  TabStop := True;
  ParentColor := False;
  FTreeNodes := TccTreeNodes.Create(Self);
  FBorderStyle := bsSingle;
  FShowButtons := True;
  FShowRoot := True;
  FShowLines := True;
  FHideSelection := True;
  FDragImage := TDragImageList.CreateSize(32, 32);
  FSaveIndent := -1;
{$IFDEF DELPHI6}
  FEditInstance := Classes.MakeObjectInstance(EditWndProc);
{$ELSE}
  FEditInstance := Forms.MakeObjectInstance(EditWndProc);
{$ENDIF}

  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FStateChangeLink := TChangeLink.Create;
  FStateChangeLink.OnChange := ImageListChange;

  FCDFont := TFont.Create;

  FInfoSpace := 5;
  FInfoColor := clBlue;

  FIntTimerNode := nil;
  FIntTimer := nil;
  FIntSclTimer := nil;
  FPrevScrollNode := nil;
  FInOnTimer := False;
  FDragSource := nil;
  FShowInfoText := True;
  FShowCheckBoxes := False;
end;

destructor TccCustomTreeView.Destroy;
begin
  Items.Free;
  FSaveItems.Free;
  FDragImage.Free;
  FMemStream.Free;
{$IFDEF DELPHI6}
  Classes.FreeObjectInstance(FEditInstance);
{$ELSE}
  Forms.FreeObjectInstance(FEditInstance);
{$ENDIF}
  FImageChangeLink.Free;
  FStateChangeLink.Free;
  FCDFont.Free;
  if FIntTimer <> nil then FIntTimer.Free;
  if FIntSclTimer <> nil then FIntSclTimer.Free;
  inherited Destroy;
end;

procedure TccCustomTreeView.CreateParams(var Params: TCreateParams);
const
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
  LineStyles: array[Boolean] of DWORD = (0, TVS_HASLINES);
  RootStyles: array[Boolean] of DWORD = (0, TVS_LINESATROOT);
  ButtonStyles: array[Boolean] of DWORD = (0, TVS_HASBUTTONS);
  EditStyles: array[Boolean] of DWORD = (TVS_EDITLABELS, 0);
  HideSelections: array[Boolean] of DWORD = (TVS_SHOWSELALWAYS, 0);
  DragStyles: array[TDragMode] of DWORD = (TVS_DISABLEDRAGDROP, 0);
  TrackSelectStyle: array[Boolean] of DWORD = (0, TVS_TRACKSELECT);
  FullRowSelectStyle: array[Boolean] of DWORD = (0, TVS_FULLROWSELECT);
  SingleExpandStyle: array[Boolean] of DWORD = (0, TVS_SINGLEEXPAND);
  ShowInfoTipStyle: array[Boolean] of DWORD = (0, TVS_INFOTIP);
  NoToolTipsStyle: array[Boolean] of DWORD = (0, TVS_NOTOOLTIPS);
begin
  InitCommonControl(ICC_TREEVIEW_CLASSES);
  inherited CreateParams(Params);
  CreateSubClass(Params, WC_TREEVIEW);
  with Params do begin
    Style := Style or LineStyles[FShowLines] or BorderStyles[FBorderStyle] or
      RootStyles[FShowRoot] or ButtonStyles[FShowButtons] or
      EditStyles[FReadOnly] or HideSelections[FHideSelection] or
      DragStyles[DragMode] or TrackSelectStyle[FTrackSelect] or
      FullRowSelectStyle[FFullRowSelect] or SingleExpandStyle[FSingleExpand] or
      ShowInfoTipStyle[FShowInfoTip] or NoToolTipsStyle[FNoToolTips];
    if Ctl3D and NewStyleControls and (FBorderStyle = bsSingle) then begin
      Style := Style and not WS_BORDER;
      ExStyle := Params.ExStyle or WS_EX_CLIENTEDGE;
    end;
    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
  end;
end;

procedure TccCustomTreeView.CreateWnd;
begin
  FStateChanging := False;
  inherited CreateWnd;
  if FMemStream <> nil then
  begin
    Items.ReadData(FMemStream);
    FMemStream.Destroy;
    FMemStream := nil;
    SetTopItem(Items.GetNodeFromIndex(FSaveTopIndex));
    FSaveTopIndex := 0;
    SetSelection(Items.GetNodeFromIndex(FSaveIndex));
    FSaveIndex := 0;
  end;
  if FSaveIndent <> -1 then Indent := FSaveIndent;
  if (Images <> nil) and Images.HandleAllocated then
    SetImageList(Images.Handle, TVSIL_NORMAL);
  if (StateImages <> nil) and StateImages.HandleAllocated then
    SetImageList(StateImages.Handle, TVSIL_STATE);
  if FShowCheckBoxes
    then SetShowCheckBoxes(True);
end;

procedure TccCustomTreeView.DestroyWnd;
var
  Node: TccTreeNode;
begin
  FStateChanging := True;
  if Items.Count > 0 then
  begin
    FMemStream := TMemoryStream.Create;
    Items.WriteData(FMemStream);
    FMemStream.Position := 0;
    Node := GetTopItem;
    if Node <> nil then FSaveTopIndex := Node.AbsoluteIndex;
    Node := Selected;
    if Node <> nil then FSaveIndex := Node.AbsoluteIndex;
  end;
  FSaveIndent := Indent;
  inherited DestroyWnd;
end;

procedure TccCustomTreeView.EditWndProc(var Message: TMessage);
begin
  try
    with Message do
    begin
      case Msg of
        WM_KEYDOWN,
        WM_SYSKEYDOWN: if DoKeyDown(TWMKey(Message)) then Exit;
        WM_CHAR: if DoKeyPress(TWMKey(Message)) then Exit;
        WM_KEYUP,
        WM_SYSKEYUP: if DoKeyUp(TWMKey(Message)) then Exit;
        CN_KEYDOWN,
        CN_CHAR, CN_SYSKEYDOWN,
        CN_SYSCHAR:
          begin
            WndProc(Message);
            Exit;
          end;
      end;
      Result := CallWindowProc(FDefEditProc, FEditHandle, Msg, WParam, LParam);
    end;
  except
    Application.HandleException(Self);
  end;
end;

procedure TccCustomTreeView.CMColorChanged(var Message: TMessage);
begin
  inherited;
  RecreateWnd;
end;

procedure TccCustomTreeView.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  if FBorderStyle = bsSingle then RecreateWnd;
end;

procedure TccCustomTreeView.CMSysColorChange(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then
  begin
    Message.Msg := WM_SYSCOLORCHANGE;
    DefaultHandler(Message);
  end;
end;

function TccCustomTreeView.AlphaSort: Boolean;
var
  I: Integer;
begin
  if HandleAllocated then
  begin
    Result := CustomSort(nil, 0);
    for I := 0 to Items.Count - 1 do
      with Items[I] do
        if HasChildren then AlphaSort;
  end
  else Result := False;
end;

function TccCustomTreeView.CustomSort(SortProc: TTVCompare; Data: Longint): Boolean;
var
  SortCB: TTVSortCB;
  I: Integer;
  Node: TccTreeNode;
begin
  Result := False;
  if HandleAllocated then
  begin
    with SortCB do
    begin
      if not Assigned(SortProc) then lpfnCompare := @DefaultTreeViewSort
      else lpfnCompare := SortProc;
      hParent := TVI_ROOT;
      lParam := Data;
      Result := TreeView_SortChildrenCB(Handle, SortCB, 0);
    end;
    for I := 0 to Items.Count - 1 do
    begin
      Node := Items[I];
      if Node.HasChildren then Node.CustomSort(SortProc, Data);
    end;
  end;
end;

procedure TccCustomTreeView.SetSortType(Value: TccSortType);
begin
  if SortType <> Value then
  begin
    FSortType := Value;
    if ((SortType in [stData, stBoth]) and Assigned(OnCompare)) or
      (SortType in [stText, stBoth]) then
      AlphaSort;
  end;
end;

procedure TccCustomTreeView.SetStyle(Value: Integer; UseStyle: Boolean);
var
  Style: Integer;
begin
  if HandleAllocated then
  begin
    Style := GetWindowLong(Handle, GWL_STYLE);
    if not UseStyle then Style := Style and not Value
    else Style := Style or Value;
    SetWindowLong(Handle, GWL_STYLE, Style);
  end;
end;

procedure TccCustomTreeView.SetBorderStyle(Value: TBorderStyle);
begin
  if BorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TccCustomTreeView.SetDragMode(Value: TDragMode);
begin
  if Value <> DragMode then
    SetStyle(TVS_DISABLEDRAGDROP, Value = dmManual);
  inherited;
end;

procedure TccCustomTreeView.SetButtonStyle(Value: Boolean);
begin
  if ShowButtons <> Value then
  begin
    FShowButtons := Value;
    SetStyle(TVS_HASBUTTONS, Value);
  end;
end;

procedure TccCustomTreeView.SetLineStyle(Value: Boolean);
begin
  if ShowLines <> Value then
  begin
    FShowLines := Value;
    SetStyle(TVS_HASLINES, Value);
  end;
end;

procedure TccCustomTreeView.SetRootStyle(Value: Boolean);
begin
  if ShowRoot <> Value then
  begin
    FShowRoot := Value;
    SetStyle(TVS_LINESATROOT, Value);
  end;
end;

procedure TccCustomTreeView.SetTrackSelectStyle(Value: Boolean);
begin
  if TrackSelect <> Value then
  begin
    FTrackSelect := Value;
    SetStyle(TVS_TRACKSELECT, Value);
  end;
end;

procedure TccCustomTreeView.SetFullRowSelectStyle(Value: Boolean);
begin
  if FullRowSelect <> Value then
  begin
    FFullRowSelect := Value;
    SetStyle(TVS_FULLROWSELECT, Value);
  end;
end;

procedure TccCustomTreeView.SetSingleExpandStyle(Value: Boolean);
begin
  if SingleExpand <> Value then
  begin
    FSingleExpand := Value;
    SetStyle(TVS_SINGLEEXPAND, Value);
  end;
end;

procedure TccCustomTreeView.SetShowInfoTip(Value: Boolean);
begin
  if ShowInfoTip <> Value then
  begin
    FShowInfoTip := Value;
    SetStyle(TVS_INFOTIP, Value);
  end;
end;

procedure TccCustomTreeView.SetNoToolTips(Value: Boolean);
begin
  if NoToolTips <> Value then
  begin
    FNoToolTips := Value;
    SetStyle(TVS_NOTOOLTIPS, Value);
  end;
end;

procedure TccCustomTreeView.SetShowCheckBoxes(Value: Boolean);
begin
  FShowCheckBoxes:= Value;
  SetComCtlStyle(Self, TVS_CHECKBOXES, Value);
  if not Value
    then StateImages := Self.StateImages;
end;

procedure TccCustomTreeView.SetReadOnly(Value: Boolean);
begin
  if ReadOnly <> Value then
  begin
    FReadOnly := Value;
    SetStyle(TVS_EDITLABELS, not Value);
  end;
end;

procedure TccCustomTreeView.SetHideSelection(Value: Boolean);
begin
  if HideSelection <> Value then
  begin
    FHideSelection := Value;
    SetStyle(TVS_SHOWSELALWAYS, not Value);
    Invalidate;
  end;
end;

function TccCustomTreeView.GetNodeAt(X, Y: Integer): TccTreeNode;
var
  HitTest: TTVHitTestInfo;
begin
  with HitTest do
  begin
    pt.X := X;
    pt.Y := Y;
    if TreeView_HitTest(Handle, HitTest) <> nil then
      Result := Items.GetNode(HitTest.hItem)
    else Result := nil;
  end;
end;

function TccCustomTreeView.GetHitTestInfoAt(X, Y: Integer): TccHitTests;
var
  HitTest: TTVHitTestInfo;
begin
  Result := [];
  with HitTest do
  begin
    pt.X := X;
    pt.Y := Y;
    TreeView_HitTest(Handle, HitTest);
    if (flags and TVHT_ABOVE) <> 0 then Include(Result, htAbove);
    if (flags and TVHT_BELOW) <> 0 then Include(Result, htBelow);
    if (flags and TVHT_NOWHERE) <> 0 then Include(Result, htNowhere);
    if (flags and TVHT_ONITEM) <> 0 then Include(Result, htOnItem);
    if (flags and TVHT_ONITEMBUTTON) <> 0 then Include(Result, htOnButton);
    if (flags and TVHT_ONITEMICON) <> 0 then Include(Result, htOnIcon);
    if (flags and TVHT_ONITEMINDENT) <> 0 then Include(Result, htOnIndent);
    if (flags and TVHT_ONITEMLABEL) <> 0 then Include(Result, htOnLabel);
    if (flags and TVHT_ONITEMRIGHT) <> 0 then Include(Result, htOnRight);
    if (flags and TVHT_ONITEMSTATEICON) <> 0 then Include(Result, htOnStateIcon);
    if (flags and TVHT_TOLEFT) <> 0 then Include(Result, htToLeft);
    if (flags and TVHT_TORIGHT) <> 0 then Include(Result, htToRight);
  end;
end;

procedure TccCustomTreeView.SeTccTreeNodes(Value: TccTreeNodes);
begin
  Items.Assign(Value);
end;

procedure TccCustomTreeView.SetIndent(Value: Integer);
begin
  if Value <> Indent then TreeView_SetIndent(Handle, Value);
end;

function TccCustomTreeView.GetIndent: Integer;
begin
  Result := TreeView_GetIndent(Handle)
end;

procedure TccCustomTreeView.FullExpand;
var
  Node: TccTreeNode;
begin
  Node := Items.GetFirstNode;
  while Node <> nil do
  begin
    Node.Expand(True);
    Node := Node.GetNextSibling;
  end;
end;

procedure TccCustomTreeView.FullCollapse;
var
  Node: TccTreeNode;
begin
  Node := Items.GetFirstNode;
  while Node <> nil do
  begin
    Node.Collapse(True);
    Node := Node.GetNextSibling;
  end;
end;

procedure TccCustomTreeView.Loaded;
begin
  inherited Loaded;
  if csDesigning in ComponentState then FullExpand;
end;

function TccCustomTreeView.GetTopItem: TccTreeNode;
begin
  if HandleAllocated then
    Result := Items.GetNode(TreeView_GetFirstVisible(Handle))
  else Result := nil;
end;

procedure TccCustomTreeView.SetTopItem(Value: TccTreeNode);
begin
  if HandleAllocated and (Value <> nil) then
    TreeView_SelectSetFirstVisible(Handle, Value.ItemId);
end;

function TccCustomTreeView.GetSelection: TccTreeNode;
begin
  if HandleAllocated then
  begin
    if FRightClickSelect and Assigned(FRClickNode) then
      Result := FRClickNode
    else
      Result := Items.GetNode(TreeView_GetSelection(Handle));
  end
  else Result := nil;
end;

procedure TccCustomTreeView.SetSelection(Value: TccTreeNode);
begin
  if Value <> nil then Value.Selected := True
  else TreeView_SelectItem(Handle, nil);
end;

function TccCustomTreeView.GetDropTarget: TccTreeNode;
begin
  if HandleAllocated then
  begin
    Result := Items.GetNode(TreeView_GetDropHilite(Handle));
    if Result = nil then Result := FLastDropTarget;
  end
  else Result := nil;
end;

procedure TccCustomTreeView.SetDropTarget(Value: TccTreeNode);
begin
  if HandleAllocated then
    if Value <> nil then Value.DropTarget := True
    else TreeView_SelectDropTarget(Handle, nil);
end;

function TccCustomTreeView.GetNodeFromItem(const Item: TTVItem): TccTreeNode;
begin
  with Item do
    if (state and TVIF_PARAM) <> 0 then Result := Pointer(lParam)
    else Result := Items.GetNode(hItem);
end;

function TccCustomTreeView.IsEditing: Boolean;
var
  ControlHand: HWnd;
begin
  ControlHand := TreeView_GetEditControl(Handle);
  Result := (ControlHand <> 0) and IsWindowVisible(ControlHand);
end;

procedure TccCustomTreeView.CNNotify(var Message: TWMNotify);
var
  pnmlv : PNMLVCustomDraw;
  htr : HTReeItem;
  DC : HDC;
  Rect: TRect;

  Node: TccTreeNode;
  MousePos: TPoint;
  pinfotip: PTSeNMTVGETINFOTIP;
  InfoTip: string;

  Color, BkColor : TColor;
begin
  with Message.NMHdr^ do
    case code of
      TVN_GETINFOTIP:
        begin
          if FDragSource = nil then begin
            pinfotip := PTSeNMTVGETINFOTIP(TMessage(Message).lParam);
            Node := Items.GetNode(pinfotip.hItem);
            InfoTip := Node.Text;
            if Assigned(FOnInfoTip) then FOnInfoTip(Node, InfoTip);
            pinfotip.pszText := PChar(InfoTip);
            pinfotip.cchTextMax := Length(InfoTip);
          end;
        end;
      TVN_BEGINDRAG:
        begin
          SetInfoTip(False);
          FDragged := True;
          with PNMTreeView(Pointer(Message.NMHdr))^ do
            FDragNode := GetNodeFromItem(ItemNew);
            FCBDragNode := FDragNode;
        end;
      TVN_BEGINLABELEDIT:
        begin
          with PTVDispInfo(Pointer(Message.NMHdr))^ do
            if Dragging or not CanEdit(GetNodeFromItem(item)) then
              Message.Result := 1;
          if Message.Result = 0 then
          begin
            FEditHandle := TreeView_GetEditControl(Handle);
            FDefEditProc := Pointer(GetWindowLong(FEditHandle, GWL_WNDPROC));
            SetWindowLong(FEditHandle, GWL_WNDPROC, LongInt(FEditInstance));
          end;
        end;
      TVN_ENDLABELEDIT:
        with PTVDispInfo(Pointer(Message.NMHdr))^ do
          Edit(item);
      TVN_ITEMEXPANDING:
        if not FManualNotify then
        begin
          with PNMTreeView(Pointer(Message.NMHdr))^ do
          begin
            Node := GetNodeFromItem(ItemNew);
            if (action = TVE_EXPAND) and not CanExpand(Node) then
              Message.Result := 1
            else if (action = TVE_COLLAPSE) and
              not CanCollapse(Node) then Message.Result := 1;
          end;
        end;
      TVN_ITEMEXPANDED:
        if not FManualNotify then
        begin
          with PNMTreeView(Pointer(Message.NMHdr))^ do
          begin
            Node := GetNodeFromItem(itemNew);
            if (action = TVE_EXPAND) then Expand(Node)
            else if (action = TVE_COLLAPSE) then Collapse(Node);
          end;
        end;
      TVN_SELCHANGING:
        with PNMTreeView(Pointer(Message.NMHdr))^ do
          if not CanChange(GetNodeFromItem(itemNew)) then
            Message.Result := 1;
      TVN_SELCHANGED:
        with PNMTreeView(Pointer(Message.NMHdr))^ do
          Change(GetNodeFromItem(itemNew));
      TVN_DELETEITEM:
        begin
          if not FStateChanging then
          begin
            with PNMTreeView(Pointer(Message.NMHdr))^ do
              Node := GetNodeFromItem(itemOld);
            if Node <> nil then
            begin
              Node.FItemId := nil;
              Items.Delete(Node);
            end;
          end;
        end;
      TVN_SETDISPINFO:
        with PTVDispInfo(Pointer(Message.NMHdr))^ do
        begin
          Node := GetNodeFromItem(item);
          if (Node <> nil) and ((item.mask and TVIF_TEXT) <> 0) then
            Node.Text := item.pszText;
        end;
      TVN_GETDISPINFO:
        with PTVDispInfo(Pointer(Message.NMHdr))^ do
        begin
          Node := GetNodeFromItem(item);
          if Node <> nil then
          begin
            if (item.mask and TVIF_TEXT) <> 0 then
              StrLCopy(item.pszText, PChar(Node.Text), item.cchTextMax);
            if (item.mask and TVIF_IMAGE) <> 0 then
            begin
              GetImageIndex(Node);
              item.iImage := Node.ImageIndex;
            end;
            if (item.mask and TVIF_SELECTEDIMAGE) <> 0 then
            begin
              GetSelectedIndex(Node);
              item.iSelectedImage := Node.SelectedIndex;
            end;
          end;
        end;
      NM_RCLICK:
        begin
          if RightClickSelect then
          begin
            GetCursorPos(MousePos);
            with PointToSmallPoint(ScreenToClient(MousePos)) do
            begin
              FRClickNode := GetNodeAt(X, Y);
              Perform(WM_RBUTTONUP, 0, MakeLong(X, Y));
            end;
          end
          else FRClickNode := Pointer(1);
        end;
      NM_CUSTOMDRAW:
        begin
          pnmlv := PNMLVCustomDraw(TMessage(Message).lParam);
          case pnmlv^.nmcd.dwDrawStage of
            CDDS_PREPAINT: Message.Result := CDRF_NOTIFYITEMDRAW;
            CDDS_ITEMPREPAINT:
              begin
                htr := Pointer(pnmlv^.nmcd.dwItemSpec);
                Node := Items.GetNode(htr);
                if FShowInfoText and (Node <> nil) and (Node.FInfoText <> '')
                  then Message.Result  := CDRF_NOTIFYPOSTPAINT
                  else Message.Result:=CDRF_DODEFAULT;
                if IsCustomDraw then begin
                  FCDFont.Assign(Font);
                  Color := Font.Color;
                  BkColor := clWindow;
                  DoCustomDraw( Node, FCDFont, Color, BkColor);
                  if (pnmlv^.nmcd.uItemState and TVGN_CARET = 0) and
                     (pnmlv^.nmcd.uItemState and TVGN_DROPHILITE = 0) and
                     (not Node.GetState(nsDrophilited)) then begin
                        pnmlv^.clrText := ColorToRGB(Color);
                        pnmlv^.clrTextBk := ColorToRGB(bkColor);
                  end;
                  SelectObject(pnmlv^.nmcd.hdc, FCDFont.Handle);
                  Message.Result  := Message.Result or CDRF_NEWFONT;
                end;
              end;
            CDDS_ITEMPOSTPAINT:
              begin
                Message.Result := CDRF_DODEFAULT;
                htr := Pointer(pnmlv^.nmcd.dwItemSpec);
                Node := Items.GetNode(htr);
                if (Node.FInfoText <> '') then begin
                  FCDFont.Assign(Font);
                  Color := FInfoColor;
                  BkColor := clWindow;
                  if IsInfoCustomDraw then DoInfoCustomDraw( Node, FCDFont, Color, BkColor);
                  DC := pnmlv^.nmcd.hdc;
                  SetTextColor(DC, ColorToRGB(Color));
                  SetBkColor(DC, ColorToRGB(BkColor));
                  SelectObject(DC, FCDFont.Handle);
                  Rect :=Node.DisplayRect(true);
                  TextOut(DC, Rect.Right + FInfoSpace, Rect.Top+1, PChar(Node.FInfoText), Length(Node.FInfoText));
                end;
              end;
          end;
        end;
    end;
end;

function TccCustomTreeView.GetDragImages: TDragImageList;
begin
  if FDragImage.Count > 0
    then Result := FDragImage
    else Result := nil;
end;

procedure TccCustomTreeView.WndProc(var Message: TMessage);
begin
  if not (csDesigning in ComponentState) and ((Message.Msg = WM_LBUTTONDOWN) or
    (Message.Msg = WM_LBUTTONDBLCLK)) and not Dragging and (DragMode = dmAutomatic) then
  begin
    if not IsControlMouseMsg(TWMMouse(Message)) then
    begin
      ControlState := ControlState + [csLButtonDown];
      Dispatch(Message);
    end;
  end
  else inherited WndProc(Message);
end;

procedure TccCustomTreeView.DoStartDrag(var DragObject: TDragObject);
var
  ImageHandle: HImageList;
  DragNode: TccTreeNode;
  P: TPoint;
begin
  inherited DoStartDrag(DragObject);
  DragNode := FDragNode;
  FLastDropTarget := nil;
  FDragNode := nil;
  if DragNode = nil then
  begin
    GetCursorPos(P);
    with ScreenToClient(P) do DragNode := GetNodeAt(X, Y);
  end;
  if DragNode <> nil then
  begin
    ImageHandle := TreeView_CreateDragImage(Handle, DragNode.ItemId);
    if ImageHandle <> 0 then
      with FDragImage do
      begin
        Handle := ImageHandle;
        SetDragImage(0, 2, 2);
      end;
  end;
end;

procedure TccCustomTreeView.DoEndDrag(Target: TObject; X, Y: Integer);
begin
  inherited DoEndDrag(Target, X, Y);
  FLastDropTarget := nil;
  SetExpandTimer(nil);
  FDragSource := nil;
  SetScrollTimer(False, []);
end;

procedure TccCustomTreeView.CMDrag(var Message: TCMDrag);
begin
  inherited;
  with Message, DragRec^ do begin
    case DragMessage of
      dmDragCancel:
        begin
          SetExpandTimer(nil);
          FDragSource := nil;
          SetScrollTimer(False, []);
          SetInfoTip(True);
        end;
      dmDragMove:
        begin
          FDragSource := Source;
          with ScreenToClient(Pos) do DoDragOver(Source, X, Y, Message.Result<>0);
        end;
      dmDragLeave:
        begin
          TDragObject(Source).HideDragImage;
          FLastDropTarget := DropTarget;
          DropTarget := nil;
          TDragObject(Source).ShowDragImage;
          FDragSource := nil;
          SetScrollTimer(False, []);
          SetExpandTimer(nil);
        end;
      dmDragDrop:
        begin
          FDragSource := nil;
          SetScrollTimer(False, []);
          SetExpandTimer(nil);
          FLastDropTarget := nil;
          SetInfoTip(True);
        end;
    end;
  end;
end;

procedure TccCustomTreeView.DoDragOver(Source: TDragObject; X, Y: Integer; CanDrop: Boolean);
var Node: TccTreeNode;
begin
  Node := GetNodeAt(X, Y);
  if not FInOnTimer then SetExpandTimer(Node);
  if (Node <> nil) and
    ((Node <> DropTarget) or (Node = FLastDropTarget)) then
  begin
    FLastDropTarget := nil;
    TDragObject(Source).HideDragImage;
    Node.DropTarget := CanDrop;
    TDragObject(Source).ShowDragImage;
  end;
end;

procedure TccCustomTreeView.GetImageIndex(Node: TccTreeNode);
begin
  if Assigned(FOnGetImageIndex) then FOnGetImageIndex(Self, Node);
end;

procedure TccCustomTreeView.GetSelectedIndex(Node: TccTreeNode);
begin
  if Assigned(FOnGetSelectedIndex) then FOnGetSelectedIndex(Self, Node);
end;

function TccCustomTreeView.CanChange(Node: TccTreeNode): Boolean;
begin
  Result := True;
  if Assigned(FOnChanging) then FOnChanging(Self, Node, Result);
end;

procedure TccCustomTreeView.Change(Node: TccTreeNode);
begin
  if Assigned(FOnChange) then FOnChange(Self, Node);
end;

procedure TccCustomTreeView.Expand(Node: TccTreeNode);
begin
  if Assigned(FOnExpanded) then FOnExpanded(Self, Node);
end;

function TccCustomTreeView.CanExpand(Node: TccTreeNode): Boolean;
begin
  Result := True;
  if Assigned(FOnExpanding) then FOnExpanding(Self, Node, Result);
end;

procedure TccCustomTreeView.Collapse(Node: TccTreeNode);
begin
  if Assigned(FOnCollapsed) then FOnCollapsed(Self, Node);
end;

function TccCustomTreeView.CanCollapse(Node: TccTreeNode): Boolean;
begin
  Result := True;
  if Assigned(FOnCollapsing) then FOnCollapsing(Self, Node, Result);
end;

function TccCustomTreeView.CanEdit(Node: TccTreeNode): Boolean;
begin
  Result := True;
  if Assigned(FOnEditing) then FOnEditing(Self, Node, Result);
end;

procedure TccCustomTreeView.Edit(const Item: TTVItem);
var
  S: string;
  Node: TccTreeNode;
begin
  with Item do
    if pszText <> nil then
    begin
      S := pszText;
      Node := GetNodeFromItem(Item);
      if Assigned(FOnEdited) then FOnEdited(Self, Node, S);
      if Node <> nil then Node.Text := S;
    end;
end;

function TccCustomTreeView.CreateNode: TccTreeNode;
begin
  Result := TccTreeNode.Create(Items);
end;

procedure TccCustomTreeView.SetImageList(Value: HImageList; Flags: Integer);
begin
  if HandleAllocated then TreeView_SetImageList(Handle, Value, Flags);
end;

procedure TccCustomTreeView.ImageListChange(Sender: TObject);
var
  ImageHandle: HImageList;
begin
  if HandleAllocated then
  begin
    ImageHandle := TImageList(Sender).Handle;
    if Sender = Images then
      SetImageList(ImageHandle, TVSIL_NORMAL)
    else if Sender = StateImages then
      SetImageList(ImageHandle, TVSIL_STATE);
  end;
end;

procedure TccCustomTreeView.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = Images
      then Images := nil;
    if AComponent = StateImages
      then StateImages := nil;
  end;
end;

procedure TccCustomTreeView.SetImages(Value: TImageList);
begin
  if Images <> nil
    then Images.UnRegisterChanges(FImageChangeLink);
  FImages := Value;
  if Images <> nil then
  begin
    Images.RegisterChanges(FImageChangeLink);
    SetImageList(Images.Handle, TVSIL_NORMAL)
  end
  else SetImageList(0, TVSIL_NORMAL);
end;

procedure TccCustomTreeView.SetStateImages(Value: TImageList);
begin
  if StateImages <> nil
    then StateImages.UnRegisterChanges(FStateChangeLink);
  FStateImages := Value;
  if StateImages <> nil then
  begin
    StateImages.RegisterChanges(FStateChangeLink);
    SetImageList(StateImages.Handle, TVSIL_STATE)
  end
  else SetImageList(0, TVSIL_STATE);
end;

procedure TccCustomTreeView.LoadFromFile(const FileName: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TccCustomTreeView.LoadFromStream(Stream: TStream);
begin
  with TTreeStrings.Create(Items) do
    try
      LoadTreeFromStream(Stream);
    finally
      Free;
  end;
end;

procedure TccCustomTreeView.SaveToFile(const FileName: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TccCustomTreeView.SaveToStream(Stream: TStream);
begin
  with TTreeStrings.Create(Items) do
    try
      SaveTreeToStream(Stream);
    finally
      Free;
  end;
end;

procedure TccCustomTreeView.WMRButtonDown(var Message: TWMRButtonDown);
var
  MousePos: TPoint;
begin
  FRClickNode := nil;
  try
    if not RightClickSelect then
    begin
      inherited;
      if FRClickNode <> nil then
      begin
        GetCursorPos(MousePos);
        with PointToSmallPoint(ScreenToClient(MousePos)) do
          Perform(WM_RBUTTONUP, 0, MakeLong(X, Y));
      end;
    end
    else DefaultHandler(Message);
  finally
    FRClickNode := nil;
  end;
end;

procedure TccCustomTreeView.WMRButtonUp(var Message: TWMRButtonUp);

  procedure DoMouseDown(var Message: TWMMouse; Button: TMouseButton;
    Shift: TShiftState);
  begin
    if not (csNoStdEvents in ControlStyle) then
      with Message do
        MouseDown(Button, KeysToShiftState(Keys) + Shift, XPos, YPos);
  end;

begin
  if RightClickSelect
    then DoMouseDown(Message, mbRight, []);
  inherited;
end;

procedure TccCustomTreeView.WMLButtonDown(var Message: TWMLButtonDown);
var
  Node: TccTreeNode;
  MousePos: TPoint;
  HitTests: TccHitTests;
  CanCheck: boolean;
begin
  FDragged := False;
  FDragNode := nil;

  if FShowCheckBoxes then
  begin
    HitTests:= GetHitTestInfoAt(Message.XPos, Message.YPos);
    if (htOnStateIcon in HitTests) and Assigned(FOnCheckChanging) then
    begin
      Node:= GetNodeAt(Message.XPos, Message.YPos);
      FOnCheckChanging(Self, Node, CanCheck);
      if CanCheck then
      begin
        inherited;
        if Assigned(FOnCheckChanged) then FOnCheckChanged(Self, Node);
      end;
    end
    else
    begin
      inherited;
    end;
  end
  else
  begin
    inherited;
  end;  

  try
    if DragMode = dmAutomatic then
    begin
      SetFocus;
      if not FDragged then
      begin
        GetCursorPos(MousePos);
        with PointToSmallPoint(ScreenToClient(MousePos)) do
          Perform(WM_LBUTTONUP, 0, MakeLong(X, Y));
      end
      else begin
        Node := GetNodeAt(Message.XPos, Message.YPos);
        if Node <> nil then
        begin
          Node.Focused := True;
          Node.Selected := True;
          BeginDrag(False);
        end;
      end;
    end;
  finally
    FDragNode := nil;
  end;
end;

procedure TccCustomTreeView.WMNotify(var Message: TWMNotify);
var
  Node: TccTreeNode;
  MaxTextLen: Integer;
  Pt: TPoint;
begin
  with Message do
    if NMHdr^.code = TTN_NEEDTEXTW then
    begin
      GetCursorPos(Pt);
      Pt := ScreenToClient(Pt);
      Node := GetNodeAt(Pt.X, Pt.Y);
      if (Node = nil) or (Node.Text = '') or
        (PToolTipTextW(NMHdr)^.uFlags and TTF_IDISHWND = 0)
        then Exit;

      if (GetComCtlVersion >= ComCtlVersionIE4) and (Length(Node.Text) < 80) then
      begin
        inherited;
        Exit;
      end;

      FWideText := Node.Text;
      MaxTextLen := SizeOf(PToolTipTextW(NMHdr)^.szText) div SizeOf(WideChar);
      if Length(FWideText) >= MaxTextLen
        then SetLength(FWideText, MaxTextLen - 1 - 3);
        
      FWideText := FWideText + '...'; 
      PToolTipTextW(NMHdr)^.lpszText := PWideChar(FWideText);
      FillChar(PToolTipTextW(NMHdr)^.szText, MaxTextLen, 0);
      Move(Pointer(FWideText)^, PToolTipTextW(NMHdr)^.szText, Length(FWideText) * SizeOf(WideChar));
      PToolTipTextW(NMHdr)^.hInst := 0;
      SetWindowPos(NMHdr^.hwndFrom, HWND_TOP, 0, 0, 0, 0, SWP_NOACTIVATE or
        SWP_NOSIZE or SWP_NOMOVE or SWP_NOOWNERZORDER);
      Result := 1;
    end
    else inherited;
end;

procedure TccCustomTreeView.RedrawNode(Node: TccTreeNode);
var
  Rect: TRect;
begin
  if FTreeNodes.FUpdateCount < 1 then
  begin
    Rect :=Node.DisplayRect(False);
    InvalidateRect(Node.GetHandle, @Rect, False);
  end;
end;

procedure TccCustomTreeView.SetInfoSpace(Value: Integer);
begin
  FInfoSpace := Value;
  Repaint;
end;

procedure TccCustomTreeView.SetInfoColor(Value: TColor);
begin
  FInfoColor := Value;
  Repaint;
end;

function TccCustomTreeView.GetFirstVisible: TccTreeNode;
begin
  Result := FTreeNodes.GetNode(TreeView_GetFirstVisible(Handle))
end;

function TccCustomTreeView.GetLastVisible: TccTreeNode;
var
  R: TRect;
begin
  R := GetClientRect;
  result := GetNodeAt(R.Right, R.Bottom);
end;

procedure TccCustomTreeView.OnTimer(Sender: TObject);
var
  Node: TccTreeNode;
begin
  if FInOnTimer
    then exit
    else FInOnTimer := True;
  try
    Node := FIntTimerNode;
    SetExpandTimer(nil);
    if FDragSource = nil
      then exit;
    if (Node <> nil) and (not Node.Expanded) and Node.HasChildren then
    begin
      FDragSource.HideDragImage;
      Node.Expand(False);
      UpdateWindow(Node.TreeView.Handle);
      FDragSource.ShowDragImage;
    end;
  finally
    FInOnTimer := False;
  end;
end;

procedure TccCustomTreeView.SetExpandTimer(Node: TccTreeNode);
begin
  if Node = nil then begin
    if FIntTimer <> nil then begin
      FIntTimer.Free;
      FIntTimer := nil;
    end;
  end else begin
    if FIntTimer = nil then begin
      FIntTimer := TTimer.Create(Self);
      FIntTimer.Interval := 500;
      FIntTimer.OnTimer := OnTimer;
    end else begin
      if FIntTimerNode <> Node then begin
        FIntTimer.Enabled := False;
        FIntTimer.Enabled := True;
      end;
    end;
  end;
  FIntTimerNode := Node;
end;

procedure TccCustomTreeView.OnSclTimer(Sender: TObject);
var
  S,P: TPoint;
  Dest: TccScrollDest;
  Message: TCMDrag;
  DragRec: PDragRec;
  R: TRect;
  Accept: Boolean;
begin
  Dest := FSclDest;
  SetScrollTimer(False, []);
  if FDragSource = nil
    then exit;
  FDragSource.HideDragImage;
  if scdsTop in Dest
    then SendMessage(Self.Handle, WM_VSCROLL, SB_LINEUP, 0);
  if scdsBottom in Dest
    then SendMessage(Self.Handle, WM_VSCROLL, SB_LINEDOWN, 0);
  if scdsLeft in Dest
    then SendMessage(Self.Handle, WM_HSCROLL, SB_LINELEFT, 0);
  if scdsRight in Dest
    then SendMessage(Self.Handle, WM_HSCROLL, SB_LINERIGHT, 0);
  FDragSource.ShowDragImage;
  GetCursorPos(S);
  P := ScreenToClient(S);
  R := GetClientRect;
  if not PtInRect(R,P)
    then exit;
  DragOver(TDragControlObject(FDragSource).Control, P.x, P.y, dsDragMove, Accept);
  if not Accept
    then exit;
  New(DragRec);
  try
    GetCursorPos(DragRec^.Pos);
    DragRec^.Source :=  FDragSource;
    DragRec^.Target :=  nil;
    Message.DragRec := DragRec;
    Message.DragMessage := dmDragMove;
    Message.Result := Integer(Accept);
    CMDrag(Message);
  finally
    Dispose(DragRec);
  end;
end;

procedure TccCustomTreeView.SetScrollTimer(Start: boolean; Dest: TccScrollDest);
begin
  if not Start then
  begin
    if FIntSclTimer <> nil then
    begin
      FIntSclTimer.Free;
      FIntSclTimer := nil;
    end;
  end
  else
  begin
    if FIntSclTimer = nil then
    begin
      FIntSclTimer := TTimer.Create(Self);
      FIntSclTimer.Interval := 100;
      FIntSclTimer.OnTimer := OnSclTimer;
    end
    else
    begin
      if FSclDest <> Dest then
      begin
        FIntSclTimer.Enabled := False;
        FIntSclTimer.Enabled := True;
      end;
    end;
  end;
  FSclDest := Dest;
end;

procedure TccCustomTreeView.WMNCHitTest(var Message: TWMNCHitTest);
var
  Node: TccTreeNode;
  P: TPoint;
  X,Y: integer;
  R,I, RTop, RBottom, RLeft, RRight: TRect;
  Dest: TccScrollDest;
  SV, SH: TScrollInfo;
  AStyle : LongInt;
begin
  inherited;
  if Message.Result = HTCLIENT then
  begin
    if FDragSource <> nil then
    begin
      Dest := [];
      R := GetClientRect;
      X := GetSystemMetrics(SM_CXVSCROLL);
      Y := GetSystemMetrics(SM_CYHSCROLL);
      I := R;
      InflateRect(I, -X, -Y);
      P.x := Message.XPos;
      P.y := Message.YPos;
      P := ScreenToClient(P);
      Node := GetNodeAt(P.x, P.y);
      if FPrevScrollNode <> Node
        then SetScrollTimer(False, []);
      FPrevScrollNode := Node;
      if PtInRect(R, P) and not(PtInRect(I, P)) then
      begin
        RTop := R;
        RBottom := R;
        RLeft := R;
        RRight := R;

        RTop.Bottom := R.Top + Y;
        RBottom.Top := R.Bottom - Y;
        RLeft.Right := R.Left + X;
        RRight.Left := R.Right - X;

        SH.cbSize := SizeOf(TScrollInfo);
        SH.fMask := SIF_ALL;
        SV.cbSize := SizeOf(TScrollInfo);
        SV.fMask := SIF_ALL;

        AStyle := GetWindowLong(Self.Handle, GWL_STYLE);
        if (AStyle and WS_HSCROLL <>0) then
        begin
          GetScrollInfo(Self.Handle, SB_HORZ, SH);
          if PtInRect(RLeft, P) and (SH.nMin <> SH.nPos)
            then Dest := Dest + [scdsLeft];
          if PtInRect(RRight, P) and (SH.nMax <> (LongInt(SH.nPage) + SH.nPos - 1))
            then Dest := Dest + [scdsRight];
        end;

        if (AStyle and WS_VSCROLL <>0) then
        begin
          GetScrollInfo(Self.Handle, SB_VERT, SV);
          if PtInRect(RTop, P) and (SV.nMin <> SV.nPos)
            then Dest := Dest + [scdsTop];
          if PtInRect(RBottom, P) and (SV.nMax <> (LongInt(SV.nPage) + SV.nPos - 1))
            then Dest := Dest + [scdsBottom];
        end;

        if Dest <> []
          then SetScrollTimer(True, Dest)
      end;
    end;
  end;
end;

procedure TccCustomTreeView.SetInfoTip(Show: boolean);
var
  TipWnd: HWND;
begin
  TipWnd := SendMessage(Self.Handle, TVM_GETTOOLTIPS, 0, 0);
  if TipWnd <> 0 then 
    if Show
      then SendMessage(TipWnd, TTM_ACTIVATE , 1, 0)
      else begin
        SendMessage(TipWnd, TTM_ACTIVATE , 0, 0);
        SendMessage(TipWnd, TTM_POP , 0, 0);
      end;
end;

function TccCustomTreeView.IsCustomDraw : Boolean;
begin
  Result := Assigned(FOnCustomDraw);
end;

function TccCustomTreeView.IsInfoCustomDraw : Boolean;
begin
  Result := Assigned(FOnInfoCustomDraw);
end;

procedure TccCustomTreeView.DoCustomDraw(TreeNode : TccTreeNode; AFont : TFont;
                                         var AColor, ABkColor : TColor);
begin
  if Assigned(FOnCustomDraw)
    then FOnCustomDraw(self, TreeNode, AFont, AColor, ABkColor);
end;

procedure TccCustomTreeView.DoInfoCustomDraw(TreeNode : TccTreeNode; AFont : TFont;
                                          var AColor, ABkColor : TColor);
begin
  if Assigned(FOnInfoCustomDraw)
    then FOnInfoCustomDraw(self, TreeNode, AFont, AColor, ABkColor);
end;

procedure TccCustomTreeView.LockUpdate;
begin
  SendMessage(Handle, WM_SETREDRAW, Integer(False), 0);
end;

procedure TccCustomTreeView.UnLockUpdate;
begin
  SendMessage(Handle, WM_SETREDRAW, Integer(True), 0);
end;

procedure TccCustomTreeView.SetShowInfoText(Value: boolean);
begin
  if FShowInfoText <> Value then
  begin
    FShowInfoText := Value;
    if FShowInfoText
      then Invalidate;
  end;
end;

procedure TccCustomTreeView.TVMSetItem(var Message: TMessage);
var
  Node: TccTreeNode;
  CanCheck: boolean;
begin
  CanCheck := True;
  with PTVItem(Message.lParam)^ do
  begin
    if (Mask and (TVIF_STATE or TVIF_HANDLE) > 0) and
       Assigned(FOnCheckChanging) then
    begin
      Node := Items.GetNode(hItem);
      FOnCheckChanging(Self, Node, CanCheck);
      if CanCheck then
      begin
        inherited;
        if Assigned(FOnCheckChanged)
          then FOnCheckChanged(Self, Node);
      end;
    end
    else
    begin
      inherited;
    end;
  end;
end;

procedure TccCustomTreeView.GetEditControl(var Message: TMessage);
begin
  inherited;
  if Assigned(FSearchTreeViewEvent) then FSearchTreeViewEvent(Message);
end;

end.
