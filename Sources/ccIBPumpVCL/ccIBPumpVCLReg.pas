{
  Copyright (c) 2000-2002 CleverComponents.com
  Product: CleverComponents Interbase DataPump VCL
  Author: Alexandre Poloziouk, alex@CleverComponents.com
  Unit: ccIBPumpVCLReg.pas
  Version: 1.0
}

unit ccIBPumpVCLReg;

{$INCLUDE ccGetVer.inc}

interface

uses
  Classes,
{$IFDEF DELPHI6}
  DesignIntf,
{$ELSE}
  DsgnIntf,
{$ENDIF}
    ccTreeView, ccTreeViewEditor, ccSpinEdit, ccButtonEdit;

procedure Register;

implementation

const
  ALibName = 'ccIBDataPump';

procedure Register;
begin
  RegisterComponents(ALibName, [TccSpinEdit]);
  RegisterComponents(ALibName, [TccButtonEdit]);
  RegisterComponents(ALibName, [TccTreeView]);
  RegisterPropertyEditor(TypeInfo(TccTreeNodes), TccTreeView, 'Items', TccTreeViewParams);
end;

end.
