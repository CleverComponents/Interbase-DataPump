{
  Copyright (c) 2000-2002 CleverComponents.com
  Product: CleverComponents Interbase DataPump VCL
  Author: Alexandre Poloziouk, alex@CleverComponents.com
  Unit: ccSpinEdit.pas
  Version: 1.0
}

unit ccSpinEdit;

{$INCLUDE ccGetVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls,
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  Mask, DBCtrls, comctrls, db, buttons, CommCtrl, ToolWin, extctrls, menus, clipbrd;

type

  { TccSpinSpeedButton }

  TccSpinSpeedButton = class(TSpeedButton)
  private
    FRepeatTimer: TTimer;
    FUp: boolean;

    procedure TimerExpired(Sender: TObject);
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Paint; override;
    procedure PaintEnd(lEn: integer);
  public
    constructor Create(AOwner: TComponent; Up: boolean); reintroduce;
    destructor Destroy; override;
  end;

  { TccSpinFieldDataLink }

  TccSpinFieldDataLink = class(TDataLink)
  private
    FField: TField;
    FFieldName: string;
    FControl: TComponent;
    FEditing: Boolean;
    FModified: Boolean;
    FOnDataChange: TNotifyEvent;
    FOnUpdateData: TNotifyEvent;
    FOnActiveChange: TNotifyEvent;
    FOnEditingChange: TNotifyEvent;

    function GetCanModify: Boolean;
    procedure SetEditing(Value: Boolean);
    procedure SetField(Value: TField);
    procedure SetFieldName(const Value: string);
    procedure UpdateField;
  protected
    procedure EditingChanged; override;
    procedure ActiveChanged; override;
    procedure FocusControl(Field: TFieldRef); override;
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
    procedure UpdateData; override;
  public
    function Edit: Boolean;
    procedure Modified;
    procedure Reset;
    property CanModify: Boolean read GetCanModify;
    property Control: TComponent read FControl write FControl;
    property Editing: Boolean read FEditing;
    property Field: TField read FField;
    property FieldName: string read FFieldName write SetFieldName;
    property OnDataChange: TNotifyEvent read FOnDataChange write FOnDataChange;
    property OnEditingChange: TNotifyEvent read FOnEditingChange write FOnEditingChange;
    property OnUpdateData: TNotifyEvent read FOnUpdateData write FOnUpdateData;
    property OnActiveChange: TNotifyEvent read FOnActiveChange write FOnActiveChange;
  end;

  { TccSpinEdit }

  TccSpinEditValueType = (vtInteger, vtFloat);

  TccSpinEdit = class(TCustomMaskEdit)
  private
    FDataLink: TccSpinFieldDataLink;
    FAlignment: TAlignment;
    FFocused: Boolean;
    FUpButton: TccSpinSpeedButton;
    FDownButton: TccSpinSpeedButton;
    FIncNow: boolean;
    FAllowEmptyText: boolean;
    FLeftPrefix: string;
    FRightPrefix: string;
    FIncrement: double;
    FMin: double;
    FMax: double;
    FValue: Variant;
    FValueType: TccSpinEditValueType;

    procedure SetLeftPrefix(Value: string);
    procedure SetRightPrefix(Value: string);
    procedure SetAlignment(Value: TAlignment);

    procedure BtnMouseUp(Sender: TObject);
    procedure BtnMouseDown(Sender: TObject);

    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetFocused(Value: Boolean);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    function IsValidChar(Key: Char): boolean;
    procedure CMWinIniChange(var Message: TWMWinIniChange); message CM_WININICHANGE;
  protected
    function GetEnabled: Boolean; reintroduce;
    procedure SetEnabled(Value: Boolean); reintroduce;
    procedure Change; override;
    function EditCanModify: Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Reset; override;
    procedure SetValue(AValue: Variant);
    function GetValue: Variant;
    procedure SetValueType(Value: TccSpinEditValueType);
    procedure CalcBtnSize;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    property Field: TField read GetField;
    property Value: Variant read GetValue write SetValue;
  published
    property AutoSelect;
    property AutoSize;
    property Anchors;
    property BorderStyle;
    property CharCase;
    property Color;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragMode;
    property Font;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property PrefixLeft : string read FLeftPrefix write SetLeftPrefix;
    property PrefixRight : string read FRightPrefix write SetRightPrefix;
    property Alignment: TAlignment read FAlignment write SetAlignment;
    property Increment: double read FIncrement write FIncrement;
    property Min: double read FMin write FMin;
    property Max: double read FMax write FMax;
    property Enabled: Boolean read GetEnabled write SetEnabled;
    property AllowEmptyText: boolean read FAllowEmptyText write FAllowEmptyText default true;
    property ValueType: TccSpinEditValueType read FValueType write SetValueType default vtInteger;
  end;

implementation

type
  TccSpinCharsSet = set of char;

var
  sDec: String;
  sEditArr: TccSpinCharsSet;

{ Common }

procedure ResetMaxLength(DBEdit: TccSpinEdit);
var
  F: TField;
begin
  with DBEdit do
  if (MaxLength > 0) and Assigned(DataSource) and Assigned(DataSource.DataSet) then
  begin
    F := DataSource.DataSet.FindField(DataField);
    if Assigned(F) and (F.DataType = ftString) and (F.Size = MaxLength)
      then MaxLength := 0;
  end;
end;

{ TccSpinEdit }

procedure TccSpinEdit.WMEraseBkgnd(var Message: TWMEraseBkgnd);
var
  R: TRect;
begin
  R := ClientRect;
  R.Right := FUpButton.Left;
  FillRect(Message.DC, R, Brush.Handle);
  Message.Result := 1;
end;

procedure TccSpinEdit.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
  if HandleAllocated
    then Self.Perform(EM_SETMARGINS, EC_RIGHTMARGIN, MakeLParam(0, FUpButton.Width));
end;

procedure TccSpinEdit.CalcBtnSize;
begin
  FUpButton.Top := 0;
  FUpButton.Height := Round((self.Height - 3) / 2);
  FUpButton.Width := GetSystemMetrics(SM_CXVSCROLL) + 2;
  FUpButton.Left := self.Width - FUpButton.Width - 3;

  FDownButton.Top := self.Height - FUpButton.Height - 3;
  FDownButton.Height := FUpButton.Height;
  FDownButton.Width := FUpButton.Width;
  FDownButton.Left := FUpButton.Left;
end;

procedure TccSpinEdit.WMSize(var Message: TWMSize);
begin
  inherited;
  CalcBtnSize;
end;

procedure TccSpinEdit.CMWinIniChange(var Message: TWMWinIniChange);
begin
  inherited;
  CalcBtnSize;
  SetBounds(Left, Top, Width, Height);
  Invalidate;
end;


procedure TccSpinEdit.WMSetCursor(var Msg: TWMSetCursor);
var
  P: TPoint;
begin
  GetCursorPos(P);
  if PtInRect(Rect(Width - FUpButton.Width - 3, 0, Width, Height), ScreenToClient(P))
    then Windows.SetCursor(LoadCursor(0, idc_Arrow))
    else inherited;
end;

constructor TccSpinEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FUpButton := TccSpinSpeedButton.Create(self,true);
  FUpButton.Parent := self;
  FUpButton.OnClick := BtnMouseUp;
  inherited ReadOnly := False;
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TccSpinFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnDataChange := DataChange;

  FDownButton := TccSpinSpeedButton.Create(self,false);
  FDownButton.Parent := self;
  FDownButton.OnClick := BtnMouseDown;

  FIncrement := 1;
  FMin := 0;
  FMax := MaxInt;
  FAllowEmptyText := true;
  FValue := 0;
  FValueType := vtInteger;
end;

destructor TccSpinEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  FUpButton.Free;
  FDownButton.Free;
  inherited Destroy;
end;

procedure TccSpinEdit.Loaded;
begin
  inherited Loaded;
  ResetMaxLength(Self);
  if (csDesigning in ComponentState)
    then DataChange(Self);
end;

procedure TccSpinEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
     (AComponent = DataSource)
    then DataSource := nil;
end;

procedure TccSpinEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  FIncNow := false;

  if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift))
    then FDataLink.Edit;

  if (Key = VK_UP) then
  begin
    FIncNow := true;
    BtnMouseUp(self);
  end;

  if (Key = VK_DOWN) then
  begin
    FIncNow := true;
    BtnMouseDown(self);
  end;
  
  FIncNow := false;
end;

procedure TccSpinEdit.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);

  if (Key in [#32..#255]) and (not IsValidChar(Key)) then
  begin
    MessageBeep(0);
    Key := #0;
    exit;
  end;

  case Key of
    ^H, ^V, ^X, #32..#255:
      begin
        if Field <> nil
          then FDataLink.Edit;
      end;    
    #27:
      begin
        if Field <> nil
          then FDataLink.Reset;
        SelectAll;
        Key := #0;
      end;
    #13:
      begin
        Key := #0;
      end;
  end;
end;

function TccSpinEdit.EditCanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

procedure TccSpinEdit.Reset;
begin
  if Field <> nil
    then FDataLink.Reset;
  SelectAll;
end;

procedure TccSpinEdit.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if (FAlignment <> taLeftJustify) and (not IsMasked)
      then Invalidate;

    if Field <> nil
      then FDataLink.Reset;
  end;
end;

procedure TccSpinEdit.Change;
begin
  if csLoading in ComponentState
    then exit;

  if Field <> nil
    then FDataLink.Modified;
  inherited Change;
end;

function TccSpinEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TccSpinEdit.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil
    then Value.FreeNotification(Self);
end;

function TccSpinEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TccSpinEdit.SetDataField(const Value: string);
begin
  if not (csDesigning in ComponentState)
    then ResetMaxLength(Self);
  FDataLink.FieldName := Value;
end;

function TccSpinEdit.GetReadOnly: Boolean;
begin
  Result := inherited ReadOnly;
  if Field <> nil
    then Result := Result or FDataLink.ReadOnly or (not FDataLink.CanModify);
end;

procedure TccSpinEdit.SetReadOnly(Value: Boolean);
begin
  inherited ReadOnly := Value;
end;

function TccSpinEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TccSpinEdit.SetLeftPrefix(Value: string);
begin
  FLeftPrefix := Value;
  DataChange(Self);
end;

procedure TccSpinEdit.SetRightPrefix(Value: string);
begin
  FRightPrefix := Value;
  DataChange(Self);
end;

procedure TccSpinEdit.SetAlignment(Value: TAlignment);
begin
  FAlignment := Value;
  DataChange(Self);
  Repaint;
end;

procedure TccSpinEdit.BtnMouseUp(Sender: TObject);
var
  Cur, New: Double;
begin
  Cur := 0;

  if Assigned(OnClick)
    then OnClick(Sender);

  if not FFocused
    then SetFocus;

  if (Field <> nil) and (not EditCanModify)
    then exit;

  if ReadOnly
    then exit;

  if Trim(Text) <> ''
    then Cur := StrToFloat(Text);

  if FMin = FMax then
  begin
    New := Cur + FIncrement
  end
  else
  begin
    if Cur < FMin
      then New := FMin
      else
        if FMax >= Cur + FIncrement
          then New := Cur + FIncrement
          else New := FMax;
  end;

  if (New <> Cur) and (Field <> nil) then
  begin
    if EditCanModify
      then Field.AsFloat := New;
  end
  else Value := VarAsType(New, varDouble);

  if not FIncNow
    then SelectAll;
end;

procedure TccSpinEdit.BtnMouseDown(Sender: TObject);
var
  Cur, New: Double;
  l: boolean;
begin
  Cur := 0;

  if Assigned(OnClick)
    then OnClick(Sender);

  if not FFocused
    then SetFocus;

  if (Field <> nil) and (not EditCanModify)
    then exit;

  if ReadOnly
    then exit;

  if Trim(Text) <> '' then
  begin
    Cur := StrToFloat(Text);
    l := False;
  end
  else
  begin
    l := True
  end;

  if FMin = FMax then
  begin
    New := Cur - FIncrement
  end
  else
  begin
    if Cur > FMax
      then New := FMax
      else
        if FMin <= Cur - FIncrement
          then New := Cur - FIncrement
          else New := FMin;
  end;

  if ((New <> Cur) or l) and (Field <> nil) then
  begin
    if EditCanModify
      then Field.AsFloat := New;
  end
  else Value := VarAsType(New, varDouble);

  if not FIncNow
    then SelectAll;
end;

procedure TccSpinEdit.DataChange(Sender: TObject);
begin
  if Field <> nil then
  begin
    EditMask := Field.EditMask;
    if not (csDesigning in ComponentState) then
    begin
      if (Field.DataType = ftString) and (MaxLength = 0)
        then MaxLength := Field.Size;
    end;

    if FFocused and FDataLink.CanModify
      then Text := VarToStr(Field.Value)
    else
    begin
      if Field.DisplayText <> ''
        then EditText := PrefixLeft + Field.DisplayText + PrefixRight
        else EditText := '';

      if FDataLink.Editing and FDataLink.FModified
        then Modified := True;
    end;
  end
  else
  begin
    EditMask := '';
    if csDesigning in ComponentState
      then EditText := Name
      else
      begin
        if FValue = NULL
          then EditText := ''
          else
            if FFocused
              then EditText := FloatToStr(FValue)
              else EditText := PrefixLeft + FloatToStr(FValue) + PrefixRight;
      end;
  end;
end;

procedure TccSpinEdit.EditingChange(Sender: TObject);
begin
end;

procedure TccSpinEdit.UpdateData(Sender: TObject);
begin
  ValidateEdit;
  try
    if (FMin <> FMax) then
    begin
      if StrToFloat(Text) < FMin
        then Text := FloatToStr(FMin);
      if StrToFloat(Text) > FMax
        then Text := FloatToStr(FMax);
    end;
  except
    on E: Exception do
    begin
      E.Message := 'Wrong format!';
      if not ((Text = '') and FAllowEmptyText)
        then Text := FloatToStr(FMin);
    end;
  end;
  Field.AsString := Text;
end;

procedure TccSpinEdit.WMPaste(var Message: TMessage);
begin
  if Field <> nil
    then FDataLink.Edit;
  inherited;
end;

procedure TccSpinEdit.WMCut(var Message: TMessage);
begin
  if Field <> nil
    then FDataLink.Edit;
  inherited;
end;

procedure TccSpinEdit.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  inherited;
  if Field = nil
    then DataChange(nil);
end;

function TccSpinEdit.GetValue: Variant;
begin
  if Field <> nil then
  begin
    FDataLink.UpdateRecord;
    result := Field.AsVariant;
  end
  else
  begin
    if FFocused then
    begin
      try
        FValue := VarAsType(StrToFloat(Text), varDouble);
        if (FMin <> FMax) then
        begin
          if StrToFloat(Text) < FMin
            then FValue := VarAsType(FMin, varDouble);
          if StrToFloat(Text) > FMax
            then FValue := VarAsType(FMax, varDouble);
        end;
      except
        on E: Exception do
        begin
          E.Message := 'Wrong format!';
          if not ((Text = '') and FAllowEmptyText)
            then FValue := VarAsType(FMin, varDouble)
            else FValue := NULL;
        end;
      end;
    end;
    result := FValue;
    Value := FValue;
 end;
end;

procedure TccSpinEdit.CMExit(var Message: TCMExit);
begin
  try
    if Field <> nil
      then FDataLink.UpdateRecord
      else
      begin
        try
          FValue := VarAsType(StrToFloat(Text), varDouble);
          if (FMin <> FMax) then
          begin
            if StrToFloat(Text) < FMin
              then FValue := VarAsType(FMin, varDouble);
            if StrToFloat(Text) > FMax
              then FValue := VarAsType(FMax, varDouble);
          end;
        except
          on E: Exception do
          begin
            E.Message := 'Wrong format!';
            if not ((Text = '') and FAllowEmptyText)
              then FValue := VarAsType(FMin, varDouble)
              else FValue := NULL;
          end;
        end;
        Value := FValue;
      end;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  SetFocused(False);
  CheckCursor;
  DoExit;
end;

procedure TccSpinEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TccSpinEdit.GetEnabled: Boolean;
begin
  result := inherited Enabled;
end;

procedure TccSpinEdit.SetEnabled(Value: Boolean);
begin
  inherited Enabled := Value;
  FUpButton.Enabled := Value;
  FDownButton.Enabled := Value;
end;

procedure TccSpinEdit.SetValue(AValue: Variant);
begin
  FValue := AValue;
  if FValue = NULL
    then Text := ''
    else
      if FFocused
        then Text := FValue
        else Text := PrefixLeft + FloatToStr(FValue) + PrefixRight;
end;

procedure TccSpinEdit.SetValueType(Value: TccSpinEditValueType);
begin
  FValueType := Value;
  if FValueType = vtInteger then
  begin
    FValue := VarAsType(0, varInteger);
    FValue := VarAsType(FValue, varInteger);
  end
  else
  begin
    FValue := VarAsType(0, varDouble);
    FValue := VarAsType(FValue, varDouble);
  end;
end;

function TccSpinEdit.IsValidChar(Key: Char): boolean;
begin
  if Field <> nil
    then result := Field.IsValidChar(Key)
    else
    begin
      result := false;
      if FValueType = vtInteger then
      begin
        if Key in sEditArr
          then result := true;
      end
      else
      begin
        if (Key = sDec) or (Key in sEditArr)
          then result := true;
      end;
    end;
end;

{ TccSpinFieldDataLink}

procedure TccSpinFieldDataLink.SetEditing(Value: Boolean);
begin
  if FEditing <> Value then
  begin
    FEditing := Value;
    FModified := False;
    if Assigned(FOnEditingChange)
      then FOnEditingChange(Self);
  end;
end;

procedure TccSpinFieldDataLink.SetFieldName(const Value: string);
begin
  if FFieldName <> Value then
  begin
    FFieldName :=  Value;
    UpdateField;
  end;
end;

procedure TccSpinFieldDataLink.SetField(Value: TField);
begin
  if FField <> Value then
  begin
    FField := Value;
    EditingChanged;
    RecordChanged(nil);
  end;
end;

procedure TccSpinFieldDataLink.UpdateField;
begin
  if Active and (FFieldName <> '') then
  begin
    if Assigned(FControl)
      then SetField(GetFieldProperty(DataSource.DataSet, FControl, FFieldName))
      else SetField(DataSource.DataSet.FieldByName(FFieldName));
  end
  else SetField(nil);
end;

function TccSpinFieldDataLink.Edit: Boolean;
begin
  if CanModify
    then inherited Edit;
  Result := FEditing;
end;

function TccSpinFieldDataLink.GetCanModify: Boolean;
begin
  Result := (not ReadOnly) and (Field <> nil) and Field.CanModify;
end;

procedure TccSpinFieldDataLink.Modified;
begin
  FModified := True;
end;

procedure TccSpinFieldDataLink.Reset;
begin
  RecordChanged(nil);
end;

procedure TccSpinFieldDataLink.ActiveChanged;
begin
  UpdateField;
  if Assigned(FOnActiveChange)
    then FOnActiveChange(Self);
end;

procedure TccSpinFieldDataLink.EditingChanged;
begin
  SetEditing(inherited Editing and CanModify);
end;

procedure TccSpinFieldDataLink.FocusControl(Field: TFieldRef);
begin
  if (Field^ <> nil) and (Field^ = FField) and (FControl is TWinControl) then
  begin
    if TWinControl(FControl).CanFocus then
    begin
      Field^ := nil;
      TWinControl(FControl).SetFocus;
    end;
  end;  
end;

procedure TccSpinFieldDataLink.RecordChanged(Field: TField);
begin
  try
    if (Field = nil) or (Field = FField) then
    begin
      if Assigned(FOnDataChange)
        then FOnDataChange(Self);
      FModified := False;
    end;
  except
  end;
end;

procedure TccSpinFieldDataLink.LayoutChanged;
begin
  UpdateField;
end;

procedure TccSpinFieldDataLink.UpdateData;
begin
  if FModified then
  begin
    if (Field <> nil) and Assigned(FOnUpdateData)
      then FOnUpdateData(Self);
    FModified := False;
  end;
end;

{ TccSpinSpeedButton }

constructor TccSpinSpeedButton.Create(AOwner: TComponent; Up: boolean);
begin
  inherited Create(AOwner);
  FUp := Up;
end;

destructor TccSpinSpeedButton.Destroy;
begin
  if FRepeatTimer <> nil
    then FRepeatTimer.Free;
  FRepeatTimer := nil;
  inherited Destroy;
end;

procedure TccSpinSpeedButton.Paint;
begin
  inherited;
  if Enabled
    then PaintEnd(0)
    else
    begin
      PaintEnd(1);
      PaintEnd(0);
    end;
end;

procedure TccSpinSpeedButton.PaintEnd(lEn: integer);
var
  xB, xE, Y, w, start: integer;
begin
  w := ClientHeight-2;
  xB := Round((ClientWidth-w)/2);
  xE := xB + w;
  start := Round((ClientHeight-2)/4);

  if not FUp
    then Y := start
    else Y := ClientHeight - start - 2;

  if FState in [bsDown] then
  begin
    if FUp
      then Dec(Y, 1)
      else Inc(Y, 1);
    Dec(xE,1);
    Dec(xB,1);
  end;

  if Enabled
    then Canvas.Pen.Color := clBtnText
    else Canvas.Pen.Color := clBtnShadow;

  if lEn <> 0 then
  begin
    Canvas.Pen.Color := clBtnHighlight;
    Inc(Y, lEn);
    Inc(xE, lEn);
    Inc(xB, lEn);
  end;

  while xB <= xE do
  begin
    Canvas.MoveTo(xB, Y);
    Canvas.LineTo(xE, Y);
    inc(xB);
    dec(xE);
    if not FUp
      then Inc(Y)
      else Dec(Y);
  end;
end;

procedure TccSpinSpeedButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown (Button, Shift, X, Y);
  if FRepeatTimer = nil
    then FRepeatTimer := TTimer.Create(Self);

  FRepeatTimer.OnTimer := TimerExpired;
  FRepeatTimer.Interval := InitRepeatPause;
  FRepeatTimer.Enabled  := True;
end;

procedure TccSpinSpeedButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp (Button, Shift, X, Y);
  if FRepeatTimer <> nil
    then FRepeatTimer.Enabled  := False;
end;

procedure TccSpinSpeedButton.TimerExpired(Sender: TObject);
begin
  FRepeatTimer.Interval := RepeatPause;
  if (FState = bsDown) and MouseCapture then
  begin
    try
      Click;
    except
      FRepeatTimer.Enabled := False;
      raise;
    end;
  end;
end;

initialization
  sDec := '0';
  GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_SDECIMAL, PChar(sDec), Length(sDec));
  sEditArr := ['0','1','2','3','4','5','6','7','8','9','-','+'];

end.
