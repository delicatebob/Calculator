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
    MC: TButton;
    MMINUS: TButton;
    MR: TButton;
    MPLUS: TButton;
    MS: TButton;
    M: TButton;
    dellastsign: TButton;
    GG: TEdit;
    Percent: TButton;
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
    procedure dellastsignClick(Sender: TObject); // Удаление последнего символа
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
    procedure FormCreate(Sender: TObject);
    procedure PercentClick(Sender: TObject);
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
  edit0:array[1..2] of real; // Для смены знака у степени числа
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
  ,f6{Для вывода 0 во 2-й edit}
  ,f7{Деление на 0}
  ,f8{Для повторения последнего действия}:boolean; //Флажки
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

procedure TForm1.dellastsignClick(Sender: TObject);   //Удаление последнего символа
var
  e:string;
begin
  if f=false then begin
  e:=edit1.text;
     if e[length(e)]=',' then
        z:=false;
     if length(e)=1 then
        edit1.text:='0'
     else begin
          delete(e,length(e),1);
          edit1.text:=e;
     end;
  end;
  edit1.setfocus
end;

// End

procedure InputRestriction; // Ограничение ввода в edit1
var p1:integer;
  p2:real;
  s:string;
Begin
  s:=form1.edit1.text;
  case length(s) of
       0..12:form1.edit1.font.Size:=39;
       13:form1.edit1.font.Size:=37;
       14:form1.edit1.font.Size:=34;
       15:form1.edit1.font.Size:=31;
       16:form1.edit1.font.Size:=29;
       17:form1.edit1.font.Size:=28;
       18:form1.edit1.font.Size:=26;
       19:form1.edit1.font.Size:=25;
       20:form1.edit1.font.Size:=24;
  end;
  for p1:=1 to length(s) do begin
          if s[p1]='1' then
             p2:=p2+0.5;
          if p2=3 then
             p2:=p2+0.5;
          if p2>6 then
             p2:=p2+0.5;
  end;
  if (length(s) in [13..20]) and (p2>0) then begin
  form1.edit1.font.Size:=form1.edit1.font.Size+round(p2);
  p2:=0;
  end;
  form1.edit1.maxlength:=15;
end;

procedure changesign; // Смена вида знака
  begin
        case znaki[i] of
             '+':form1.gg.text:=form1.gg.text+'+';
             '-':form1.gg.text:=form1.gg.text+'−';
             '*':form1.gg.text:=form1.gg.text+'×';
             '/':form1.gg.text:=form1.gg.text+'÷';
        end;
  end;

procedure Myp; //Заполнение 2-го edit'а
var
e,e2:string;
begin
  if form1.edit1.text<>'0' then begin
  if f4=true then begin
        e:=floattostr(chisla[i]);
        case znaki[i] of
             '+':form1.gg.text:=form1.gg.text+e+'+';
             '-':form1.gg.text:=form1.gg.text+e+'−';
             '*':form1.gg.text:=form1.gg.text+e+'×';
             '/':form1.gg.text:=form1.gg.text+e+'÷';
     end;
  end;
     end;
       if f4=false then begin
        e2:=form1.gg.text;
        delete(e2,length(e2),1);
        form1.gg.text:=e2;
        changesign;
     end;
  end;

procedure Tform1.Edit1KeyPress(Sender: TObject; var Key: char);
begin
 if  (key in ['0'..'9','*','/','-','+',',','=',#8,#13,'%']) then begin // Блокировка всех символов, невходящих в состав необходимых
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
  #8:begin dellastsign.Enabled:=false; sleep(50); dellastsign.enabled:=true; dellastsign.click; key:=#0;  end;
  '%':begin percent.enabled:=false; sleep(50); percent.enabled:=true; percent.click; key:=#0; end;
 end;
 end
  else
  key:=#0;
  edit1.SetFocus;
 end;

procedure Lock;
begin    //  Блокировка кнопок
  form1.gg.clear;
  Form1.edit1.text:='Ошибка!';
  InputRestriction;
  Form1.ChangeOfSignOfTheDegree.enabled:=false;
  Form1.ChangeOfSign.enabled:=false;
  Form1.MinusSign.enabled:=false;
  Form1.MultiplicationSign.enabled:=false;
  Form1.DivisionSign.enabled:=false;
  form1.Square.enabled:=false;
  Form1.SquareRoot.enabled:=false;
  Form1.Plus.enabled:=false;
  Form1.Ce.enabled:=false;
  form1.percent.enabled:=false;
  f:=true;
  f8:=false;
  chisla[255]:=0;
  chisla[254]:=0;
  znaki[255]:=#0;
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
  Form1.percent.enabled:=True;
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
    InputRestriction;
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
       znaki[i] := #0;
   end;
   i := 0;
   z := false;
   Edit1.text := '0';
   f2 := false;
   f3:=false;
   f4:=true;
   f5:=false;
   f6:=false;
   edit1.SetFocus;
   gg.clear;
   InputRestriction;
   f8:=false;
   chisla[255]:=0;
   chisla[254]:=0;
   znaki[255]:=#0;
end;

procedure TForm1.SquareClick(Sender: TObject); //Возведение в квадрат
var e:real;
begin
  e:=StrToFloat(edit1.text);
  e:=e*e;
  edit1.MaxLength:=18;
  Edit1.text:=floattostr(e);
  f2:=false;
  f3:=true;
  edit1.SetFocus;
  InputRestriction;
end;

procedure TForm1.SquareRootClick(Sender: TObject); // Корень квадратный
var e:real;
begin
  e:=StrToFloat(edit1.text);
  if (e>=0) then begin
  e:=sqrt(e);
  edit1.maxlength:=18;
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
  InputRestriction;
end;

procedure TForm1.CeClick(Sender: TObject); // Отчистка неполная
  begin
      z:=false;
      Edit1.text:='0';
      f2:=false;
      edit1.SetFocus;
      InputRestriction;
  end;

procedure TForm1.ChangeOfSignClick(Sender: TObject); // Смена знака числа
  var
    e:real;
  begin
  e:=StrToFloat(edit1.text);
  e*=-1;
  edit1.maxlength:=16;
  Edit1.text:=floattostr(e);
   f2:=false;
   f3:=false;
   edit1.SetFocus;
   InputRestriction;
end;

procedure TForm1.ChangeOfSignOfTheDegreeClick(Sender: TObject);  //Смена знака степени у числа
var
e:real;
begin
 if f2=false then
    edit0[1]:=strtofloat(edit1.text);
 if (edit1.text<>'0') then begin
    if f2=false then
    edit0[2]:=1/edit0[1];
    edit1.maxlength:=18;
    if f2=false then
    edit1.text:=floattostr(edit0[2])
    else  begin
    edit1.text:=floattostr(edit0[1]);
    edit0[1]:=edit0[1]+edit0[2];
    edit0[2]:=edit0[1]-edit0[2];
    edit0[1]:=edit0[1]-edit0[2];
    end;
 end
 else begin
    lock;
    f2:=false;
   end;
f2:=true;
e:=strtofloat(edit1.text);
if frac(e) = 0 then  // Проверка запятой
   z:=false;
f3:=true;
edit1.SetFocus; // Фокус на edit1
InputRestriction;  // Настройка Edit1'a
end;


procedure TForm1.CommaClick(Sender: TObject);  // Запятая
begin
  unlock;
  edit;
  edit2;
  if (z=false) then
     if (edit1.text<>'') then begin
        z:=True;
        edit1.maxlength:=16;
        Edit1.text:=edit1.Text+',';
     end
     else begin
        edit1.text:='0,';
        z:=true;
     end;
     InputRestriction;
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
   if (edit1.text='0') then
     if f4=true then begin
     gg.text:=gg.text+'0';
     changesign;
     end;
   f8:=false;
   chisla[255]:=0;
   chisla[254]:=0;
   znaki[255]:=#0;
  Myp;
  if (znaki[i-1] = '/') and (edit1.text = '0') and (i>=2) then
  lock;
end;

 procedure TForm1.EqualSignClick(Sender: TObject);  //Равно
 var
 g,j{Чтобы проверять массив}
 :integer;
 otvet:real; //Ответ
begin
otvet:=0;
edit1.SetFocus;
gg.clear;
unlock;
if (znaki[i] = '/') and (edit1.text ='0') then begin
         f7:=true;
         lock;
         end;
if f7=false then begin
if edit1.text='' then
   znaki[i]:=#0;
 if (znaki[1]<>#0) then begin
    if edit1.text<>'' then begin
       chisla[i+1]:=strtofloat(edit1.text);
    g:=i+1;
    chisla[255]:=strtofloat(edit1.text);
    znaki[255]:=znaki[i];
    end;
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
    for j:=1 to g-1 do
        if znaki[j]='-' then
           chisla[j+1]*=-1;
    for j:=1 to g do begin
        otvet:=otvet+chisla[j];
        chisla[j]:=0;
        znaki[j]:=#0;
    end;
    f8:=true;
    form1.edit1.maxlength:=20;
           edit1.text:=floattostr(otvet);
    InputRestriction;
    g:=0;
    i:=0;
    z:=false;
    f1:=false;
    f2:=false;
    f3:=true;
 end
 else
     if (f8=true)  then begin
        case znaki[255] of
          '+':edit1.text:=floattostr(strtofloat(edit1.text)+chisla[255]);
          '-':edit1.text:=floattostr(strtofloat(edit1.text)-chisla[255]);
          '*':edit1.text:=floattostr(strtofloat(edit1.text)*chisla[255]);
          '/':edit1.text:=floattostr(strtofloat(edit1.text)/chisla[255]);
        end;
     end;
 end;
f4:=true;
f5:=false;
f7:=false;
end;

procedure TForm1.FormCreate(Sender: TObject);
  begin
  f4:=true;
end;

procedure TForm1.PercentClick(Sender: TObject);  //Процент
var
temp: real;
begin
  if (znaki[i] <>#0) THEN
  begin
    if (Edit1.Text = '') THEN
       Edit1.Text := FloatToStr(chisla[i]);
    temp := chisla[i]/100*StrToFloat(Edit1.Text);
    Edit1.Text := FloatToStr(temp);
  end
  else begin
       temp:=strtofloat(edit1.text);
       temp:=temp/100;
       edit1.text:=floattostr(temp);
  end;
  if frac(temp) = 0 then  // Проверка запятой
     z:=false;
  f2:=false;
  f3:=true;
  edit1.SetFocus; // Фокус на edit1
  InputRestriction;  // Настройка Edit1'a
end;
end.

