unit Unit1;

{$mode objfpc}{$H+}

interface

uses
Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
StdCtrls, LCLType, ExtCtrls, Buttons, Windows;

type

  { TForm1 }

  TForm1 = class(TForm)
    But0: TButton;
    But1: TButton;
    But7: TButton;
    But8: TButton;
    But9: TButton;
    GG: TEdit;
    Plus: TButton;
    Comma: TButton;
    ChangeOfSign: TButton;
    EqualSign: TButton;
    MultiplicationSign: TButton;
    MinusSign: TButton;
    DivisionSign: TButton;
    Square: TButton;
    SquareRoot: TButton;
    CE: TButton;
    ChangeOfSignOfTheDegree: TButton;
    C: TButton;
    But2: TButton;
    But4: TButton;
    But5: TButton;
    But6: TButton;
    But3: TButton;
    Edit1: TEdit;
    //Убирание каретки Begin
    procedure Edit1Click1(Sender: TObject);
    procedure edit1keyup(Sender: TObject; var Key: Word; Shift: TShiftState);
    //end
    procedure CeClick(Sender: TObject);   // Отчистка неполная
    procedure ChangeOfSignClick(Sender: TObject); // Смена знака числа
    procedure ChangeOfSignOfTheDegreeClick(Sender: TObject); // Смена знака у степени числа
    procedure CommaClick(Sender: TObject); // Запятая
    procedure Edit1KeyPress(Sender: TObject; var Key: char); // Запрет всех символов, кроме цифр
    procedure EqualSignClick(Sender: TObject); // Знак равно
    procedure Signs(Sender: TObject); // Основные знаки (+,-,/,*)
    procedure CClick(Sender: TObject); // Отчистка полная
    procedure SquareClick(Sender: TObject); // Квадрат числа
    procedure SquareRootClick(Sender: TObject); // Квадратный корень числа
    procedure WOW(Sender: TObject); // Цифры от 0 до 9
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  chisla:array[1..255] of real; // Массив со всеми числами
  znaki:array[1..255] of char; // Массив со всеми знаками
  i:integer; // Кол-во чисел и знаков
  t:real; // Для смены знака у степени числа
  z{Для запятой}
  ,f {Для блокировки кнопок}
  ,f1 {Чтобы число оставалось на экране до момента набора следующего}
  ,f2 {Для возвращения целого числа при обратной смене знака у степени числа}
  ,f3 {Чтобы число удалялось после выполнения действий, если с ним больше ничего не делают}
  ,f4,f5{Для смены знака во 2-м edit'e,если число не менялось}
  ,f6{Для вывода 0 во 2-й edit}:boolean; //Флажки
implementation

{$R *.lfm}

{ TForm1 }

// Отключение каретки  Begin
procedure TForm1.Edit1Keyup(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  HideCaret(Edit1.Handle);
  edit1.SelLength:=0;
end;
procedure TForm1.Edit1Click1(Sender: TObject);
begin
  HideCaret(Edit1.Handle);
  edit1.SelLength:=0;
end;

// End

procedure Myp; //Заполнение 2-го edit'а
var
e,e1:string;
begin
  if f6=false then begin
     if f4=false then begin
        e1:=form1.gg.text;
        delete(e1,length(e1),1);
        case znaki[i] of
             '+':form1.gg.text:=e1+'+';
             '-':form1.gg.text:=e1+'−';
             '*':form1.gg.text:=e1+'×';
             '/':form1.gg.text:=e1+'÷';
        end;
        form1.gg.text:=e1+znaki[i];
     end
     else begin
        e:=floattostr(chisla[i]);
        case znaki[i] of
             '+':form1.gg.text:=form1.gg.text+e+'+';
             '-':form1.gg.text:=form1.gg.text+e+'−';
             '*':form1.gg.text:=form1.gg.text+e+'×';
             '/':form1.gg.text:=form1.gg.text+e+'÷';
        end;
     end;
  end;
  f6:=false;
end;

procedure Tform1.Edit1KeyPress(Sender: TObject; var Key: char);
var
  e:string;
begin
 if  (key in ['0'..'9','*','/','-','+',',','=',#8,#13]) then begin // Блокировка всех символов, невходящих в состав необходимых
 case key of
  '0':begin but0.enabled:=false; sleep(50); but0.enabled:=true;   but0.click; key:=#0; end;
  '1':begin but1.enabled:=false; sleep(50); but1.enabled:=true; but1.click; key:=#0; end;
  '2':begin but2.enabled:=false; sleep(50); but2.enabled:=true; but2.click; key:=#0; end;
  '3':begin but3.enabled:=false; sleep(50); but3.enabled:=true; but3.click; key:=#0; end;
  '4':begin but4.enabled:=false; sleep(50); but4.enabled:=true; but4.click; key:=#0; end;
  '5':begin but5.enabled:=false; sleep(50); but5.enabled:=true; but5.click; key:=#0; end;
  '6':begin but6.enabled:=false; sleep(50); but6.enabled:=true; but6.click; key:=#0; end;
  '7':begin but7.enabled:=false; sleep(50); but7.enabled:=true; but7.click; key:=#0; end;
  '8':begin but8.enabled:=false; sleep(50); but8.enabled:=true; but8.click; key:=#0; end;
  '9':begin but9.enabled:=false; sleep(50); but9.enabled:=true; but9.click; key:=#0; end;
  '+':begin plus.enabled:=false; sleep(50); plus.enabled:=true; plus.click; key:=#0; end;
  '-':begin MinusSign.enabled:=false; sleep(50); MinusSign.enabled:=true; MinusSign.click; key:=#0; end;
  '*':begin MultiplicationSign.enabled:=false; sleep(50); MultiplicationSign.enabled:=true; MultiplicationSign.click; key:=#0; end;
  '/':begin divisionSign.enabled:=false; sleep(50); divisionSign.enabled:=true; divisionSign.click; key:=#0; end;
  ',':begin comma.enabled:=false; sleep(50); comma.enabled:=true;  comma.click; key:=#0; end;
  '=',#13:begin EqualSign.enabled:=false; sleep(50); EqualSign.enabled:=true;  EqualSign.click; key:=#0; end;
  #8:begin if f=false then begin e:=edit1.text;if e[length(e)]=',' then z:=false; if length(e)=1 then begin edit1.text:='0'; key:=#0; end else begin delete(e,length(e),1); edit1.text:=e; key:=#0; end; end; end;
 end;
 end
  else
  key:=#0;
  edit1.SetFocus;
 end;

procedure Lock;
begin    //  Блокировка кнопок
  form1.gg.clear;
  Form1.edit1.text:='Ошибка';
  Form1.ChangeOfSignOfTheDegree.enabled:=false;
  Form1.ChangeOfSign.enabled:=false;
  Form1.MinusSign.enabled:=false;
  Form1.MultiplicationSign.enabled:=false;
  Form1.DivisionSign.enabled:=false;
  form1.Square.enabled:=false;
  Form1.SquareRoot.enabled:=false;
  Form1.Plus.enabled:=false;
  Form1.Ce.enabled:=false;
  f:=true;
end;

procedure Unlock;
var
j:integer;
begin
if f=True then begin    //  Отключение блокировки кнопок
  Form1.ChangeOfSignOfTheDegree.enabled:=True;
  Form1.ChangeOfSign.enabled:=True;
  Form1.MinusSign.enabled:=True;
  Form1.MultiplicationSign.enabled:=True;
  Form1.DivisionSign.enabled:=True;
  form1.Square.enabled:=True;
  Form1.SquareRoot.enabled:=True;
  Form1.Plus.enabled:=True;
  Form1.Ce.enabled:=True;
  f:=false;
  Form1.edit1.text:='0';
  for j:=1 to i+1 do begin
      chisla[i]:=0;
      znaki[i]:=' ';
  end;
  i:=0;
  z:=false;
end;
end;

procedure edit; // Чтобы число оставалось на экране до момента набора следующего
begin
if f1=true then begin
   Form1.edit1.clear;
   f1:=false;
end;
end;

procedure edit2; // Чтобы число удалялось после выполнения действий, если с ним больше ничего не делают
begin
if f3=true then
   form1.Edit1.clear;
end;

procedure TForm1.WOW(Sender: TObject); //Цифры
  begin
    Unlock;
    edit;
    edit2;
    if (edit1.text='0') then
       edit1.clear;
    Edit1.text:=Edit1.text+(sender as Tbutton).caption;
    f2 := false;
    f3 := false;
    edit1.SetFocus;
    f4 := true;
    f5 := false;
    if (edit1.text = '00') then
       Edit1.Caption := '0';
  end;

procedure TForm1.CClick(Sender: TObject); // Отчистка полная
begin
unlock;
   for I := 1 to i+1 do begin
       chisla[i] := 0;
       znaki[i] := ' ';
   end;
   i := 0;
   z := false;
   Edit1.text := '0';
   f2 := false;
   f3:=false;
   f4:=false;
   f5:=false;
   edit1.SetFocus;
   gg.clear;
end;

procedure TForm1.SquareClick(Sender: TObject); //Возведение в квадрат
var e:real;
begin
  e:=StrToFloat(edit1.text);
  e:=e*e;
  Edit1.text:=floattostr(e);
  f2:=false;
  f3:=true;
  edit1.SetFocus;
end;

procedure TForm1.SquareRootClick(Sender: TObject); // Корень квадратный
var e:real;
begin
  e:=StrToFloat(edit1.text);
  if (e>=0) then begin
  e:=sqrt(e);
  Edit1.text:=floattostr(e)
  end
  else begin
  lock;
  end;
  if frac(e)=0 then
  z:=false;
  f2:=false;
  f3:=true;
  edit1.SetFocus;
end;

procedure TForm1.CeClick(Sender: TObject); // Отчистка неполная
  begin
      z:=false;
      Edit1.text:='0';
      f2:=false;
      edit1.SetFocus;
  end;

procedure TForm1.ChangeOfSignClick(Sender: TObject); // Смена знака числа
  var
    e:real;
  begin
  e:=StrToFloat(edit1.text);
  e*=-1;
  Edit1.text:=floattostr(e);
   f2:=false;
   f3:=false;
   edit1.SetFocus;
end;

procedure TForm1.ChangeOfSignOfTheDegreeClick(Sender: TObject);  //Смена знака степени у числа
var
e:real;
label 1;
begin
e:=strtofloat(edit1.text);
if f2=true then begin
   edit1.text:=floattostr(t);
   f2:=false;
end;
if (e<>0) then begin
   t:=e;
   e:=1/e;
   edit1.text:=floattostr(e);
end
else
    lock;
f2:=true;
1:
if frac(e) = 0 then
   z:=false;
f3:=true;
edit1.SetFocus;
end;


procedure TForm1.CommaClick(Sender: TObject);  // Запятая
begin
  unlock;
  edit;
  edit2;
  if (z=false) then
     if (edit1.text<>'') then begin
        z:=True;
        Edit1.text:=edit1.Text+',';
     end
     else begin
        edit1.text:='0,';
        z:=true;
     end;
     F2:=false;
     f3:=false;
     edit1.SetFocus;
end;


procedure TForm1.signs(Sender: TObject); // Действия
  begin
   z:=False;
   if f5=true then
   f4:=false;
   if f4=true then begin
   i:=i+1;
   chisla[i]:=strtofloat(edit1.text);
   f5:=true;
   end;
   case (sender as Tbutton).caption of
        '+':znaki[i]:='+';
        '−':znaki[i]:='-';
        '×':znaki[i]:='*';
        '÷':znaki[i]:='/';
   end;
   f1:=true;
   f2:=false;
   f3:=false;
   edit1.SetFocus;
   if (edit1.text='0') then begin
      f6:=true;
      if (chisla[i-1]=0) then
          form1.gg.text:=form1.gg.text+'0'+znaki[i]
      else
          Form1.gg.text
  end;
  Myp;
  if (znaki[i-1] = '/') and (edit1.text = '0') then
  lock;
 end;

 procedure TForm1.EqualSignClick(Sender: TObject);  //Равно
 var g,j:integer;
 otvet:real;
begin
edit1.SetFocus;
gg.clear;
unlock;
 if {(chisla[1]<>0) and} (znaki[1]<>'') then begin
 if edit1.text='' then
 znaki[i]:=' ';
 chisla[i+1]:=strtofloat(edit1.text);
 g:=i+1;
 for j:=1 to g do begin
 if znaki[j]='*' then begin
 chisla[j+1]:=chisla[j]*chisla[j+1];
 chisla[j]:=0;
 end;
 if (znaki[j]='/') and (chisla[j+1]<>0) then begin
 chisla[j+1]:=chisla[j]/chisla[j+1];
 chisla[j]:=0;
 end;
 end;
 for j:=1 to g do
 if znaki[j]='-' then
 chisla[j+1]*=-1;
 for j:=1 to g do begin
 otvet:=otvet+chisla[j];
 chisla[j]:=0;
 end;
 if (znaki[i] = '/') and (edit1.text = '0') then
    lock
 else
     edit1.text:=floattostr(otvet);
 g:=0;
 i:=0;
 z:=false;
 f1:=false;
 f2:=false;
 f3:=true;
 end;
 end;
 end.

