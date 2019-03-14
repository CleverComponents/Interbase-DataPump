{
  Copyright (c) 2000-2002 CleverComponents.com
  Product: CleverComponents Interbase DataPump VCL
  Author: Alexandre Poloziouk, alex@CleverComponents.com
  Unit: ccTreeViewEditor.pas
  Version: 1.0
}

unit ccTreeViewEditor;

{$INCLUDE ccGetVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls,
{$IFDEF DELPHI6}
  DesignIntf,
  DesignEditors,  
{$ELSE}
  DsgnIntf,
{$ENDIF}
    ccTreeView, ccTreeViewItemsEditor;

type

  { TccTreeViewParams }

  TccTreeViewParams = class(TPropertyEditor)
  public
    function GetValue: string; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

implementation

{ TccTreeViewParams }

function TccTreeViewParams.GetValue: string;
begin
  Result := Format('(%s)', [TccTreeViewParams.ClassName]);
end;

function TccTreeViewParams.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paDialog];
end;

procedure TccTreeViewParams.Edit;
begin
  if EditCCTreeView(TccTreeView(GetComponent(0))) then Modified;
end;

end.
