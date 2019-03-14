{
  Copyright (c) 2000-2005 CleverComponents.com
  Product: Interbase DataPump
  Author: Alexandre Poloziouk
  Unit: ibpHelp.pas
}

unit ibpHelp;

{$INCLUDE ccGetVer.inc}

interface

uses
  Windows, Classes, Controls, Forms, ShellApi, ExtCtrls, jpeg;

type

  { TibpHelp }

  TibpHelp = class(TForm)
    Logo: TImage;
    Image1: TImage;
    Image2: TImage;
    procedure Image1Click(Sender: TObject);
    procedure LogoClick(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  end;

var
  FibpHelp: TibpHelp;

implementation

uses ibpMain;

{$R *.DFM}

{ TibpHelp }

procedure TibpHelp.Image1Click(Sender: TObject);
begin
  ShellExecute( 0, PChar('open'), PChar(AppHome), nil, nil, SW_RESTORE);
end;

procedure TibpHelp.Image2Click(Sender: TObject);
begin
  ShellExecute( 0, PChar('open'), PChar('mailto:' + AppEmail), nil, nil, SW_RESTORE);
end;

procedure TibpHelp.LogoClick(Sender: TObject);
begin
  Close;
end;

procedure TibpHelp.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 27
    then Close;
end;

end.
