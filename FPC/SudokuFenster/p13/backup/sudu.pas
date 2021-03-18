unit sudu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, LCLType;

type
  { TSudoku }

  TSudoku = class(TForm)
    Button1: TButton;
    Button10: TButton;
    Button11: TButton;
    Button3: TButton;
    Button5: TButton;
    Button7: TButton;
    Button9: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Memo1: TMemo;
    Panel1: TPanel;
    Shape1: TShape;
    SI: TShape;
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Edit1EditingDone(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit2KeyPress(Sender: TObject; var Key: char);
    procedure Edit2UTF8KeyPress(Sender: TObject; var UTF8Key: TUTF8Char);
    procedure FormCreate(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
  private
    { private declarations }
    PR: TPanel;
    SA: TShape;
    PA: TPanel;
    PI: TPanel;
    procedure editElement(Sender: TObject);
    // procedure TestClick(Sender: TObject);  <<<<<<<<<< geht auch <<<<<<<<<<<<<<<<
  public
    { public declarations }
  type
    Tstr1 = array[1..9] of char;
    Tcol1 = array[1..9] of Tcolor;
  Type
    TTest = Object
      var
        Test : TPanel;
        procedure TestClick(Sender: TObject);  //<<<<<<<<<<<<<<<< geht auch <<<<<<<<<<<<<<<<
      end;

    TRaetsel = Object
      var
        S : TPanel;         // Sudoku
      const
        x0 = 30; y0 = 110;  // linke obere Ecke
        xl = 635; yl = 635; // Abmessungen
      end;

    TElement = Object
      type
        TEE = array[1..9,1..9] of TEdit;
        TEP = array[1..9,1..9] of TPanel;
        TES = array[1..9,1..9] of TShape;
      var
        EE : TEE;           // 81 Elemente Edit
        EP : TEP;           // 81 Elemente Panel
        ES : TES;           // 81 Elemente Shape
      const
        x0 = 2; y0 = 2;     // linke obere Ecke
        xl = 70; yl = 70;   // Abmessungen
        csk =  clInactiveCaption;
        xE0 = 0;  yE0 = 20; // linke obere Ecke Edit
        xEl = 70; yEl = 70; // Abmessungen Edit
        EdHeight = 16;      // Höhe Edit
      end;

    TZiffer = Object
      type
        TZP = array[1..9,1..9,1..3,1..3] of TPanel;
        TZS = array[1..9,1..9,1..3,1..3] of TShape;
      var
        ZP : TZP;  // 81 Elemente mit je 9 Zahlen Panel
        ZS : TZS;  // 81 Elemente mit je 9 Zahlen Shape
      const
        x0 = 4; y0 = 4;         // linke obere Ecke
        xl = 20; yl = 20;       // Abmessungen
        cpk = clHighlightText;  // Farbe Hintergrund
        csk = clHighlightText;  // Farbe Shape
      end;

    const
      clNeutral : Tcolor = clDefault;   // weiß Mode 2
      clEffekt :  Tcolor = clAqua;      // blau Mode 1
      clTreffer : Tcolor = clFuchsia;   // rot  Mode 4
      clGeloest : Tcolor = clSilver;    // blau wird gesetzt, wenn nur eine Position 1 ist
      clBasis   : Tcolor = clRed;       // rot  Mode 2
      clWirkung : Tcolor = clblue;      // blau Mode 4

    type
        Er_type = array[1..81] of Word;

    var
        Rl : Er_type;   // Felder mit den gültigen Elementen in dem Raetsel
//          Rl     mögliche Ziffern im Element
//       000000000   -
//       000000001   1
//       000000010   2
//       000000011   2,1
//       000000100   3
//       000001000   4
//       000010000   5
//       000100000   6
//       001000000   7
//       010000000   8
//       !00000000   9
//       111111111   9,8,7,6,5,4,3,2,1
        visbool : BOOLEAN;
        visedit : BOOLEAN;
        elNr : integer;
        inpKey : char;

  end;     //   TSudoku = class(TForm)

var
  Sudoku: TSudoku;
  R : Sudoku.TRaetsel;
  E : Sudoku.TElement;
  Z : Sudoku.TZiffer;
  T : Sudoku.TTest;
var
  i, k : integer;

//procedure TestClick(Sender: TObject);                  // <<<<<<< geht nicht <<<<<<<

implementation

{$R *.lfm}

procedure TSudoku.Edit2UTF8KeyPress(Sender: TObject; var UTF8Key: TUTF8Char);// Edit2UTF8
begin
Sudoku.memo1.lines.add('Hier ist Edit2UTF8KeyPress : Tag: '
+inttostr((sender as Tedit).tag)+' ElNr: '+inttostr(elNr));
end;

procedure TSudoku.Edit2KeyDown(Sender: TObject; var Key: Word; // Edit2KeyDown
  Shift: TShiftState);
begin
Sudoku.memo1.lines.add('Hier ist Edit2KeyDown >>>>> : Tag: '
+inttostr((sender as Tedit).tag)+' ElNr: '+inttostr(elNr));
end;

procedure TSudoku.Edit2Exit(Sender: TObject);            // Edit2Exit
var
 ix, iy, izx, izy, ZiNr, na: integer;
 xa : string;
begin
  edit2.setfocus;
// große und kleine Ziffern setzen
  Button11Click(self);
// ES Element_Shape neutral färben
  for ix := 1 to 9 do
   for iy := 1 to 9 do
     E.ES[ix,iy].Pen.color := E.csk;
// ES Element_Shape einfärben
  //elNr := (Sender as TPanel).Tag;
  if elNr = 81 then  elNr := 1 else elNr := elNr +1;
  iy := Trunc((elNr-1)/9)+1;
  ix := elNr - (iy-1) *9;
  Sudoku.memo1.lines.add('Hier ist Edit2Exit: '//+'Tag: '+inttostr((Sender as TPanel).Tag)
   + ' ix: '+inttostr(ix)+' iy: '+inttostr(iy)
   + inttostr((sender as Tedit).tag) + ' ElNr: ' + inttostr(elNr)
   + ' Umschalten auf 9*9 <<<<<< '+' ord(inpKey):'+ inttostr(ord(inpKey)));
  E.ES[ix,iy].Pen.color := clTreffer;
  if ord(inpKey)= 27 then           // Eingabe von Escape
   begin
     Sudoku.memo1.lines.add('Edit2KeyPress: '+' elNr: '+ inttostr(elNr)
     +' ix: '+inttostr(ix)+' iy: '+inttostr(iy)+' ord(inpkey): '
     +inttostr(ord(inpkey)) +' <<<<<<<');
     Sudoku.ActiveControl := Edit1;
     //Button3.SetFocus;
   end;
end;

procedure TSudoku.EditElement(Sender: TObject);          // EditElement
var
 ix, iy, izx, izy, ZiNr, na: integer;
 xa : string;
begin
  edit2.setfocus;
// große und kleine Ziffern setzen
  Button11Click(self);
// ES Element_Shape neutral färben
  for ix := 1 to 9 do
   for iy := 1 to 9 do
    E.ES[ix,iy].Pen.color := E.csk;
// ES Element_Shape einfärben
  elNr := (Sender as TPanel).Tag;
  iy := Trunc((elNr-1)/9)+1;
  ix := elNr - (iy-1) *9;
  Sudoku.memo1.lines.add('EditElement: '+'Tag: '+inttostr((Sender as TPanel).Tag)
  +' ix: '+inttostr(ix)+' iy: '+inttostr(iy)+' Umschalten auf 9*9 <<<<<<');
  E.ES[ix,iy].Pen.color := clTreffer;
// auf 9*9 Ziffern umschalten zum Editieren
// With E.EP[ix,iy] do visible := FALSE;

end;

procedure TSudoku.Button11Click(Sender: TObject);        // ShowRl[]
var
 ix, iy, izx, izy, na, ielNr, ZiNr, k : integer;
 xa : string;
begin
  // bei mehreren ziffern muss die Grafik auf 9*9 umgestellt werden!!!!!
 for iy := 1 to 9 do
  for ix := 1 to 9 do
    begin
       E.ES[ix,iy].Pen.color := E.csk; // ES Element_Shape wird neutral gesetzt
       ielNr := (iy-1)*9 + ix;
       case Rl[ielNr] of
         1,2,4,8,16,32,64,128,256 :    // --> nur 1 Ziffer
       begin
         for k := 1 to 9 do
           begin
             if Rl[ielNr] and (%1 SHL (k-1)) > 0 then
             begin
               xa := inttostr(k);
             end
           end;
         for izx := 1 to 3 do
          for izy := 1 to 3 do
             begin
               With Z.ZP[ix,iy,izx,izy] do Visible:= FALSE;
               With Z.ZS[ix,iy,izx,izy] do Visible:= FALSE;
             end;
         With E.EP[ix,iy] do
           begin
             caption := xa;
             font.size:= 36;
             Color := E.csk; // clMenuHighlight;
           end;
       end otherwise                   // --> mehrere Ziffern
        begin
        with E.EP[ix,iy] do
        begin
           caption := '';
           Color := clWindow;
        end;
       // E.EP[ix,iy].caption := '';
        E.ES[ix,iy].Pen.color := E.csk;
       // E.EP[ix,iy].Color := clWindow; // clMenuHighlight;
        for izy := 1 to 3 do
         for izx := 1 to 3 do
          begin
             ZiNr := izx + (izy-1) * 3;
             if Rl[ielNr] and (%1 shl (ZiNr-1)) > 0 then na := ZiNr else na := 0;
             xa := inttostr(na);
             if xa = '0' then xa := '';
             With Z.ZP[ix,iy,izx,izy] do
               begin
                 Visible:= TRUE;
                 font.size:= 12;
                 caption := xa;
               end
             //if ielNr = 81 then
             //memo1.Lines.add('Hier ist Setze Rl[]: '+' ielNr: '+ inttostr(ielNr)
             //+' na: '+ inttostr(na) +' ZiNr: '+ inttostr(ZiNr)
             //+' Rl[ielNr]: '+ inttostr(Rl[ielNr]));
          end;
       end;
      end;
    end;
end;

procedure TSudoku.Button1Click(Sender: TObject);
begin
   FormCreate(self);
end;

procedure TSudoku.Edit2KeyPress(Sender: TObject; var Key: char);  // Edit2KeyPress
var
 ix, iy, izx, izy, bn, rn, xn, yn, zn, Code, ZiNr, na: Integer;
 xa : string;
begin
   inpKey := Key;
   iy := Trunc((elNr - 1)/9) + 1;
   ix := elNr - (iy -1) * 9;
   if key in (['1'..'9']) then
    begin
      Val (key,bn,Code);          // Ziffer von key
      rn := (%1 shl (bn-1));      // Ziffer als binäre Entsprechung 2 = %10
      xn := (Rl[elNr]);           // Rl[elNr] als bin Entsprechung alle 9 möglichen Ziffern
      yn := rn and xn;            // wenn key in RL[] gesetzt ist, dann > 0;sonst 0

      izy := Trunc((bn - 1)/3) + 1;
      izx := bn - (izy -1) * 3;
      if yn =0 then
       begin
          Rl[elNr] := Rl[elNr] or (%1 shl (bn-1));
          Z.ZP[ix,iy,izx,izy].caption := key;
       end else
       begin
          Rl[elNr] := Rl[elNr] xor (%1 shl (bn-1));
          Z.ZP[ix,iy,izx,izy].caption := '';
       end;
    end;
    //Val (key,bn,Code);          // Ziffer von key
    memo1.Lines.add('Hier ist edit2keypressed: key: '+key
    +' key-num: '+ inttostr(ord(key))+' elNr: '+ inttostr(elNr)
    +' bn: '+ inttostr(bn)+' rn: '+ inttostr(rn)+' xn: '+ inttostr(xn)
    +' yn: '+ inttostr(yn)+' Rl[elNr]: '+ inttostr(Rl[elNr]));
    if ord(key)= 13 then           // Eingabe von Return
     begin
       memo1.Lines.add('Hier ist edit2keypressed: key Return: '+key
       +' key-num: '+ inttostr(ord(key))+' elNr: '+ inttostr(elNr));
       // große kleine ziffern setzen
       Button11Click(self);
       // ES Element_Shape neutral färben
        for ix := 1 to 9 do
         for iy := 1 to 9 do
          E.ES[ix,iy].Pen.color := E.csk;
        // ES Element_Shape einfärben
        if elNr = 81 then elNr := 1 else elNr := elNr +1;
        iy := Trunc((elNr-1)/9)+1;
        ix := elNr - (iy-1) *9;
        E.EP[ix,iy].caption := '';
        for izy := 1 to 3 do
          for izx := 1 to 3 do
           begin
              ZiNr := izx + (izy-1) * 3;
              if Rl[elNr] and (%1 shl (ZiNr-1)) > 0 then na := ZiNr else na := 0;
              xa := inttostr(na);
              if xa = '0' then xa := '';
              With Z.ZP[ix,iy,izx,izy] do
                begin
                  Visible:= TRUE;
                  font.size:= 12;
                  caption := xa;
                end
           end;
        Sudoku.memo1.lines.add('Edit2KeyPress: '+' elNr: '+ inttostr(elNr)
        +' ix: '+inttostr(ix)+' iy: '+inttostr(iy));
        E.ES[ix,iy].Pen.color := clTreffer;
     end;
     //if ord(key)= 27 then           // Eingabe von Escape
     // begin
     //   Sudoku.memo1.lines.add('Edit2KeyPress: '+' elNr: '+ inttostr(elNr)
     //   +' ix: '+inttostr(ix)+' iy: '+inttostr(iy)+' ord(key): '
     //   +inttostr(ord(key)));
     //   Edit1.SetFocus;
     // end;
end;

procedure TSudoku.Edit1EditingDone(Sender: TObject);     // EditingDone
var
  b,aus : string;
  i,k,l,m,bn,Code : integer;
begin
  //memo1.lines.add('EditingDone: '+E.EE[1,1].Text+ 'Tab:'+inttostr(E.EE[1,1].TabOrder));
  //if Sender = Edit1 then memo1.lines.add('EditingDone'+' Edit1');
  //if Sender = E.EE[2,1] then memo1.lines.add('EditingDone'+' E.EE[2,1] ='+E.EE[2,1].Text);
  memo1.lines.add('EditingDone: '+' Tag: '+
  inttostr((Sender as TEdit).Tag)+' Text: '+(Sender as TEdit).Text);
  m := (Sender as TEdit).Tag;
  b := (Sender as TEdit).Text;
  k := length(b);
  aus := '';
  Rl[m] := %0;
  for i:= 1 to k do
  begin
    if b[i] in (['1'..'9']) then
    begin
      Val (b[i],bn,Code);
      Rl[m] := Rl[m] or (%1 shl (bn-1));
      aus := aus + b[i];
    end;
  end;
  memo1.lines.add(inttostr(m)+'-'+inttostr(Rl[m])+'-'+aus);
  // Edit end
  Button5Click(nil);         // Edit end
  // Ausgabe
  Button10Click(nil);        // Ausgabe Zufall
end;

// procedure TestClick(Sender: TObject);                 // <<<<<<< geht nicht <<<<<<<<
// procedure TSudoku.TTest.TestClick(Sender: TObject);   // <<<<<<<<<<<<<<<
procedure Tsudoku.TTest.TestClick(Sender: TObject);      // <<<<<<< geht <<<<<<<<
begin
    Sudoku.memo1.lines.add('Hier ist testclick');
end;

procedure TSudoku.Panel1Click(Sender: TObject);          // Panel1
begin
    memo1.Lines.add('Hier ist Panel1Click');
   // TestClick;
end;

procedure TSudoku.Button10Click(Sender: TObject);        // Ausgabe Zufall
type
   Tid = array[1..9,1..2] of integer;
   Tia = array[1..81,1..2] of integer;
const
// 9 Ziffern werde 3*3 Felderd zugeordnet
 id : Tid = ((1,1),(2,1),(3,1),(1,2),(2,2),(3,2),(1,3),(2,3),(3,3));
// 81 Elemente werde 9*9 Felderd zugeordnet
 ia : Tia = ((1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),
             (1,2),(2,2),(3,2),(4,2),(5,2),(6,2),(7,2),(8,2),(9,2),
             (1,3),(2,3),(3,3),(4,3),(5,3),(6,3),(7,3),(8,3),(9,3),
             (1,4),(2,4),(3,4),(4,4),(5,4),(6,4),(7,4),(8,4),(9,4),
             (1,5),(2,5),(3,5),(4,5),(5,5),(6,5),(7,5),(8,5),(9,5),
             (1,6),(2,6),(3,6),(4,6),(5,6),(6,6),(7,6),(8,6),(9,6),
             (1,7),(2,7),(3,7),(4,7),(5,7),(6,7),(7,7),(8,7),(9,7),
             (1,8),(2,8),(3,8),(4,8),(5,8),(6,8),(7,8),(8,8),(9,8),
             (1,9),(2,9),(3,9),(4,9),(5,9),(6,9),(7,9),(8,9),(9,9));
var
  b : string;
  nzahl,ix,iy,izx,izy : integer;
begin
for i := 1 to 81 do
    begin
      //memo1.lines.add(inttostr(i)+ ' : ' +inttostr(Rl[i]));
      case Rl[i] of
        1,2,4,8,16,32,64,128,256 :
        begin
        // E.ES[ia[i,1],ia[i,2]].pen.color := clgreen;
// grosse Ziffer
        for k := 1 to 9 do
          begin
            if Rl[i] and (%1 SHL (k-1)) > 0 then
            begin
              b := inttostr(k)  // +'-'+inttostr(Rl[i]);
            end
          end;
        ix := ia[i,1];
        iy := ia[i,2];
        for izx := 1 to 3 do
         for izy := 1 to 3 do
            begin
              With Z.ZP[ix,iy,izx,izy] do Visible:= FALSE;
              With Z.ZS[ix,iy,izx,izy] do Visible:= FALSE;
            end;
        With E.EP[ix,iy] do
          begin
            caption := b;
            font.size:= 36;
          end;
        end;
// kleine Ziffer
      otherwise
       // E.ES[ia[i,1],ia[i,2]].pen.color := E.csk;
       ix := ia[i,1];
       iy := ia[i,2];
      for izx := 1 to 3 do
       for izy := 1 to 3 do
            begin
              With Z.ZP[ix,iy,izx,izy] do Visible:= TRUE;
              With Z.ZS[ix,iy,izx,izy] do Visible:= TRUE;
            end;
       With E.EP[ix,iy] do
            begin
              caption := '';
              font.size:= 0;
            end;
      nzahl := 0;
      for k := 1 to 9 do
          begin
            if Rl[i] and (%1 SHL (k-1)) > 0 then
            begin
              b := inttostr(k);
              nzahl := nzahl + 1;
            end
            else b := ' ';
            Z.ZP[ia[i,1],ia[i,2],id[k,1],id[k,2]].caption := b;
          end;
      end;
    end;
end;

procedure TSudoku.Button5Click(Sender: TObject);         // Edit end
var
  ix,iy,izx,izy:integer;
begin
  visbool := TRUE;
  visEdit := FALSE;
  // memo1.Lines.add('EditEnd ist hier');
  For iy := 1 to 9 do
    For ix := 1 to 9 do
      begin
      //  EP Element_Panel
          With E.EP[ix,iy] do visible := true;
      //  ES Element_Shape
          with E.ES[ix,iy] do visible := visbool;
      //  EE Element_Edit
      //    with E.EE[ix,iy] do visible := visEdit;
      end;
  for ix := 1 to 9 do
   for iy := 1 to 9 do
    begin
         for izx := 1 to 3 do
          for izy := 1 to 3 do
           begin
           // Ziffer Panel
              With Z.ZP[ix,iy,izx,izy] do
              begin
                 visible := visbool;
              end;
           end;
    end;
end;

procedure TSudoku.Button9Click(Sender: TObject);         // Zufall Setzen
begin
for i := 1 to 81 do
  begin
    Rl[i] := Random(512)+1;
  end;
Button11Click(self);         // ShowRl[]
end;

procedure TSudoku.Button7Click(Sender: TObject);         // ZifferAlle
var
  ix,iy,izx,izy,i:integer;
begin
for ix := 1 to 9 do
 for iy := 1 to 9 do
  for izx := 1 to 3 do
   for izy := 1 to 3 do
    begin
      With Z.ZP[ix,iy,izx,izy] do
      begin
         //left := z.x0 + (izx-1)* z.xl+1; top := z.y0 + (izy-1)* z.yl+1;
         //Width :=z.xl-2; Height := z.yl-2;
         color := z.cpk;
         caption:='';  //'-'+inttostr(ix)+inttostr(iy);
      end
    end;
for i := 1 to 81 do
    Rl[i] := %0;
end;

procedure TSudoku.FormCreate(Sender: TObject);           // FormCreate
var
  ix,iy,izx,izy,iTag : Integer;
begin
Sudoku.visbool := TRUE;
Sudoku.visEdit := FALSE;

//Sudoku.Visible := False;

// Panel Raetsel
R.S:=TPanel.Create(Self);
R.S.Parent:=Self;
With R.S do
begin
  left := R.x0 ; top := R.y0;
  Width := R.xl; Height := R.yl;
  color := clScrollBar;
end;
// Element
  For iy := 1 to 9 do
    For ix := 1 to 9 do
      begin
      //  EP Element_Panel
          E.EP[ix,iy]:=TPanel.Create(Self);
          E.EP[ix,iy].Parent:=R.S;
          With E.EP[ix,iy] do
            begin
              left := E.x0 + (ix - 1) * E.xl; top := E.y0+ (iy - 1) * E.yl;
              Width := E.xl; Height := E.yl;
              font.size := 36;
              caption := '';
            end;
      //  ES Element_Shape
          E.ES[ix,iy] := TShape.Create(Self);
          E.ES[ix,iy].Parent := E.EP[ix,iy];
          with E.ES[ix,iy] DO
          Begin
             left := 0; top := 0;
             Width := E.xl; Height := E.yl;
             pen.color := E.csk;
             pen.style := psSolid;
             pen.width := 2;
             brush.Color := clnone;
             brush.Style := bsclear;
          end;
      end;
  for ix := 1 to 9 do
   for iy := 1 to 9 do
    begin
         iTag := ((iy - 1)*9) + ix;
         for izx := 1 to 3 do
          for izy := 1 to 3 do
           begin
           // Ziffer Panel
            Z.ZP[ix,iy,izx,izy] := TPanel.Create(Self);
            Z.ZP[ix,iy,izx,izy].Parent := E.EP[ix,iy];
              With Z.ZP[ix,iy,izx,izy] do
              begin
                 left := z.x0 + (izx-1)* (z.xl+2); top := z.y0 + (izy-1)* (z.yl+2);
                 Width := z.xl-2; Height := z.yl-2;
                 color := z.cpk;
                 font.size:= 12;
                 caption := ' '; //inttostr(ix)+inttostr(iy);
                 visible := visbool;
                 tag := itag;
//                 OnClick := @Button1Click;       //<<<<<<<< proc_edit <<<<<<<<<<<
                 OnClick := @EditElement;       //<<<<<<<< proc_edit <<<<<<<<<<<
              end;
            // Ziffer Shape
              Z.ZS[ix,iy,izx,izy]:=TShape.Create(Self);
              Z.ZS[ix,iy,izx,izy].Parent:= E.EP[ix,iy];
              with Z.ZS[ix,iy,izx,izy] DO
              Begin
                 left := z.x0-2 + (izx-1)* (z.xl+2); top := z.y0-2 + (izy-1)* (z.yl+2);
                 Width :=z.xl+2; Height := z.yl+2;
                 pen.color := z.csk;
                 pen.style := psSolid;
                 pen.width := 2;
                 //  brush.Color := clnone;
                 brush.style := bsClear;
                 visible := visbool;
              end;
           end;
    end;
  //showmessage('nach create');
end;

procedure TSudoku.Button3Click(Sender: TObject);         // Halt
begin
  halt(0);
end;

end.


