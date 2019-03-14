{ ccGetVer.inc }

{$B-} { Complete Boolean Evaluation }
{$R-} { Range-Checking }
{$T-} { Typed @ operator }
{$X+} { Extended syntax }
{$P+} { Open string params }
{$J+} { Writeable structured consts }
{$H+} { Use long strings by default }
{$Q-} { Overflow checking }

{$IFDEF VER130} { Delphi 5.0 }
  {$DEFINE DELPHI5}
{$ENDIF}

{$IFDEF VER140} { Delphi 6.0 }
  {$DEFINE DELPHI5}
  {$DEFINE DELPHI6}
{$ENDIF}

{$IFDEF VER150} { Delphi 7.0 }
  {$DEFINE DELPHI5}
  {$DEFINE DELPHI6}
  {$DEFINE DELPHI7}
{$ENDIF}

{$DEFINE CCNEWS}