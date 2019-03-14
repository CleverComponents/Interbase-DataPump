{
  Copyright (c) 2000-2002 CleverComponents.com
  Product: CleverComponents Interbase DataPump VCL
  Author: Alexandre Poloziouk, alex@CleverComponents.com
  Unit: ccButtonEdit.pas
  Version: 1.0
}

unit ccButtonEdit;

{$INCLUDE ccGetVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, StdCtrls,
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  Mask, comctrls, buttons, CommCtrl;

type

  { TccButtonEdit }

  TccButtonEdit = class(TMaskEdit)
  private
    FButton: TSpeedButton;
    FOnButtonClick: TNotifyEvent;

    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure CMWinIniChange(var Message: TWMWinIniChange); message CM_WININICHANGE;
  protected
    procedure ButtonClick(Sender: TObject);
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure CalcBtnSize;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
  published
    property OnButtonClick: TNotifyEvent read FOnButtonClick write FOnButtonClick;
  end;

implementation

{ TccButtonEdit }

constructor TccButtonEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FButton := TSpeedButton.Create(Self);
  FButton.Parent := Self;
  FButton.OnClick := ButtonClick;
  FButton.Caption := '...';
end;

destructor TccButtonEdit.Destroy;
begin
  FButton.Free;
  inherited Destroy;
end;

procedure TccButtonEdit.WMEraseBkgnd(var Message: TWMEraseBkgnd);
var
  R: TRect;
begin
  R := ClientRect;
  R.Right := FButton.Left;
  FillRect(Message.DC, R, Brush.Handle);
  Message.Result := 1;
end;

procedure TccButtonEdit.WMSize(var Message: TWMSize);
begin
  inherited;
  CalcBtnSize;
end;

procedure TccButtonEdit.CMWinIniChange(var Message: TWMWinIniChange);
begin
  inherited;
  CalcBtnSize;
  SetBounds(Left, Top, Width, Height);
  Invalidate;
end;

procedure TccButtonEdit.WMSetCursor(var Msg: TWMSetCursor);
var
  P: TPoint;
begin
  GetCursorPos(P);
  if PtInRect(Rect(Width - FButton.Width - 3, 0, Width, Height), ScreenToClient(P))
    then Windows.SetCursor(LoadCursor(0, idc_Arrow))
    else inherited;
end;

procedure TccButtonEdit.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
  if HandleAllocated
    then Self.Perform(EM_SETMARGINS, EC_RIGHTMARGIN, MakeLParam(0, FButton.Width));
end;

procedure TccButtonEdit.CalcBtnSize;
begin
  FButton.Top := 0;
  FButton.Height := Self.ClientHeight;
  FButton.Width := GetSystemMetrics(SM_CXVSCROLL) + 2;
  FButton.Left := Self.Width - FButton.Width - 3;
end;

procedure TccButtonEdit.ButtonClick(Sender: TObject);
begin
  if Assigned(FOnButtonClick)
    then FOnButtonClick(Self);
end;

procedure TccButtonEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);

  if (Key = VK_DOWN)
    then ButtonClick(Self);
end;

end.
