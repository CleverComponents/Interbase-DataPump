//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------

typedef void (__stdcall *LPIBDataPumpCallBack)(PChar ARepLine);

typedef int (__stdcall *LPIBPumpExec)(PChar AProfile, PChar ASourceFile, PChar ADestFile,
  LPIBDataPumpCallBack ACallBack);

typedef void (__stdcall *LPIBPumpShow)(void);

void __stdcall ShowProgress(PChar ARepLine)
{
  Form1->Memo1->Lines->Add(ARepLine);
}

//---------------------------------------------------------------------------
void __fastcall TForm1::ShowIBPumpClick(TObject *Sender)
{
  if (!m_hDLL) return;
  void* DLLFunc;
  DLLFunc = GetProcAddress(m_hDLL, "IBPumpShow");
  if (DLLFunc)
  {
    (*(LPIBPumpShow)DLLFunc)();
  }
}
//---------------------------------------------------------------------------
void __fastcall TForm1::RunSilentClick(TObject *Sender)
{
  if (!m_hDLL) return;
  void* DLLFunc;
  int Res;
  AnsiString AProfile, ASourceFile, ADestFile;
  Memo1->Lines->Clear();
  AProfile = "E:\\Progs\\IBDataPump\\DbDemos1.ibp";
//  ASourceFile = "d:\\ibdata\\bs.gdb";
//  ADestFile = "d:\\ibdata\\bstest.gdb";
  ASourceFile = "";
  ADestFile = "";

  DLLFunc = GetProcAddress(m_hDLL, "IBPumpExec");
  if (DLLFunc)
  {
    Res = (*(LPIBPumpExec)DLLFunc)(AProfile.c_str(), ASourceFile.c_str(), ADestFile.c_str(), ShowProgress);
    if (Res == 0) ShowMessage("All Fine.");
    if (Res == -1) ShowMessage("Error!");
    if (Res > 0) ShowMessage("Errors during pumping - " + IntToStr(Res));
  }
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormCreate(TObject *Sender)
{
  m_hDLL = LoadLibrary("IBPumpPlug.dll");
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormDestroy(TObject *Sender)
{
  FreeLibrary(m_hDLL);
}
//---------------------------------------------------------------------------
