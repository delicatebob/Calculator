unit Unit1;

{$mode objfpc}{$H+}

interface

uses
Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
StdCtrls, LCLType, ExtCtrls, Buttons, ComCtrls, DbCtrls, Menus, Windows, Math, Unit2;

type

  { TForm1 }

  TForm1 = class(TForm)
    But0: TButton;
    But1: TButton;
    Degree1: TButton;
    divbut: TButton;
    lnbut: TButton;
    Pibut: TButton;
    Factorial: TButton;
    Degree: TButton;
    modbut: TButton;
    sinbut: TButton;
    cosbut: TButton;
    tgbut: TButton;
    ctgbut: TButton;
    logbut: TButton;
    But7: TButton;
    But8: TButton;
    But9: TButton;
    MainMenu: TMainMenu;
    MC: TButton;
    View: TMenuItem;
    Help: TMenuItem;
    Normal: TMenuItem;
    Engineering: TMenuItem;
    Creator: TMenuItem;
    MMINUS: TButton;
    MR: TButton;
    MPLUS: TButton;
    MS: TButton;
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
    procedure CreatorClick(Sender: TObject);
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
    procedure EngineeringClick(Sender: TObject);  //Инженерный вид
    procedure EqualSignClick(Sender: TObject); // Знак равно
    procedure FactorialClick(Sender: TObject); // Факториал
    procedure FormCreate(Sender: TObject); //Настройка переменных сразу при запуске программы
    procedure GGClick(Sender: TObject);
    procedure HelpClick(Sender: TObject); //Блокировка кнопки Создатель
    procedure lnbutClick(Sender: TObject); //ln
    procedure MClick(Sender: TObject); // Память
    procedure NormalClick(Sender: TObject); // Обычный вид
    procedure PercentClick(Sender: TObject); // Процент
    procedure PibutClick(Sender: TObject); // Число Пи
    procedure Signs(Sender: TObject); // Основные знаки (+,-,/,*)
    procedure CClick(Sender: TObject); // Отчистка полная
    procedure sincostgctgbutClick(Sender: TObject); // Синус,Косинус,Тангенс,Котангенс
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
  //Память
  buffer1:string;
  buffer:double;
  //end
  edit0:array[1..2] of double; // Для смены знака у степени числа
  chisla:array[1..255] of double; // Массив со всеми числами
  znaki:array[1..255] of char; // Массив со всеми знаками
  i,i1:integer; // Кол-во чисел и знаков
  t:real; // Для смены знака у степени числа
  z{Для запятой}
  ,f {Для блокировки кнопок}
  ,f1 {Чтобы число оставалось на экране до момента набора следующего}
  ,f2 {Для возвращения целого числа при обратной смене знака у степени числа}
  ,f3 {Чтобы число удалялось после выполнения действий, если с ним больше ничего не делают}
  ,f4,f5{Для смены знака во 2-м edit'e,если число не менялось}
  ,f6{Для вывода 0 во 2-й edit}
  ,f7{Деление на 0}
  ,f8{Для повторения последнего действия}
  ,f9{Для переполнения}:boolean; //Флажки
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
//end

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
  edit1.setfocus;
end;

procedure TForm1.CreatorClick(Sender: TObject); // Вызов 2-й формы
begin
  form2.show;
  form1.creator.enabled:=false;
end;

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
             '^':form1.gg.text:=form1.gg.text+'^';
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
             'l':form1.gg.text:=form1.gg.text+e+'l';
             'm':form1.gg.text:=form1.gg.text+e+'m';
             'd':form1.gg.text:=form1.gg.text+e+'d';
             'v':form1.gg.text:=form1.gg.text+e+'v';
             '^':form1.gg.text:=form1.gg.text+e+'^';
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
  if f9=true then
     Form1.edit1.text:='Переполнение!'
  else
      Form1.edit1.text:='Ошибка!';
  form1.edit1.font.Size:=35;
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
  form1.dellastsign.enabled:=false;
  form1.MR.enabled:=false;
  form1.MPLUS.enabled:=false;
  form1.MMINUS.enabled:=false;
  form1.MS.enabled:=false;
  form1.MC.enabled:=false;
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
  form1.dellastsign.enabled:=true;
  form1.MR.enabled:=true;
  form1.MPLUS.enabled:=true;
  form1.MMINUS.enabled:=true;
  form1.MS.enabled:=true;
  form1.MC.enabled:=true;
  f:=false;
  f9:=false;
  Form1.edit1.text:='0';
  for j:=1 to i+1 do begin
      chisla[i]:=0;
      znaki[i]:=' ';
  end;
  i:=0;
  z:=false;
end;
 if buffer1='' then begin
 Form1.MC.enabled:=false;
 Form1.MR.enabled:=false;
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

procedure TForm1.sincostgctgbutClick(Sender: TObject); //Синус,Косинус,Тангенc,Котангентс
var e:real;
begin
  e:=0;
  e:=strtofloat(edit1.text);
  edit1.MaxLength:=20;
  case (sender as Tbutton).caption of
  'sin':Begin  if (frac(e/180)=0) then edit1.text:='0' else edit1.text:=floattostr(sin(e*pi/180));  end;
  'cos':begin if (frac(e/90)=0) and (frac(e/180)<>0) then edit1.text:='0' else edit1.text:=floattostr(cos(e*pi/180));  end;
  'tg':begin if (frac(e/90)=0) and (frac(e/180)<>0) then lock else edit1.text:=floattostr(sin(e*pi/180)/cos(e*pi/180)); end;
  'ctg':begin if frac(e/180)=0 then lock else edit1.text:=floattostr(cos(e*pi/180)/sin(e*pi/180)); end;
  end;
  F3:=true;
  InputRestriction;
end;

procedure TForm1.SquareClick(Sender: TObject); //Возведение в квадрат
var e:double;
begin
  e:=StrToFloat(edit1.text);
  e:=e*e;
  edit1.MaxLength:=20;
  Edit1.text:=floattostr(e);
  f2:=false;
  f3:=true;
  edit1.SetFocus;
  InputRestriction;
end;

procedure TForm1.SquareRootClick(Sender: TObject); // Корень квадратный
var e:double;
begin
  e:=StrToFloat(edit1.text);
  if (e>=0) then begin
  e:=sqrt(e);
  edit1.maxlength:=20;
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
    e:double;
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
e:double;
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
 end;
f2:=true;
e:=strtofloat(edit1.text);
if frac(e) = 0 then  // Проверка запятой
   z:=false;
f3:=true;
edit1.SetFocus; // Фокус на edit1
InputRestriction;  // Настройка Edit1'a
 if edit1.text='0' then begin
    lock;
    f2:=false;
   end;
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
        'log':znaki[i]:='l';
        'mod':znaki[i]:='m';
        'div':znaki[i]:='d';
        'ª√x':znaki[i]:='v';
        'xª':znaki[i]:='^';
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
  if ((znaki[i-1] = '/') or (znaki[i-1] = 'm') or (znaki[i-1] = 'd')) and (edit1.text = '0') and (i>=2) then
  lock;
end;

 procedure TForm1.EqualSignClick(Sender: TObject);  //Равно
 var
 g,j{Чтобы проверять массив}
 :integer;
 otvet,e:double; //Ответ
begin
otvet:=0;
edit1.SetFocus;
gg.clear;
unlock;
if ((znaki[i] = '/') or (znaki[i] = 'm') or (znaki[i] = 'd')) and (edit1.text ='0') then begin
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
    for j:=1 to g-1 do
        if znaki[j]='-' then
           chisla[j+1]*=-1;
    for j:=1 to g do begin
        if znaki[j]='l' then begin
        chisla[j+1]:=ln(chisla[j])/ln(chisla[j+1]);
        chisla[j]:=0;
        end;
        if znaki[j]='m' then begin
        e:=chisla[j]/chisla[j+1];
        chisla[j+1]:=frac(e)*chisla[j+1];
        chisla[j]:=0;
        end;
        if znaki[j]='d' then begin
        e:=chisla[j]/chisla[j+1];
        chisla[j+1]:=e-frac(e);
        chisla[j]:=0;
        end;
        if znaki[j]='v' then begin
        chisla[j+1]:=exp(ln(chisla[j])*(1/chisla[j+1]));
        chisla[j]:=0;
        end;
        if znaki[j]='^' then begin
        chisla[j+1]:=Power(chisla[j],chisla[j+1]);
        chisla[j]:=0;
        end;
        if znaki[j]='*' then begin
           chisla[j+1]:=chisla[j]*chisla[j+1];
           chisla[j]:=0;
        end;
        if (znaki[j]='/') and (chisla[j+1]<>0) then begin
           chisla[j+1]:=chisla[j]/chisla[j+1];
           chisla[j]:=0;
        end;
    end;
    for j:=1 to g do begin
        otvet:=otvet+chisla[j];
        chisla[j]:=0;
        znaki[j]:=#0;
    end;
    f8:=true;
    form1.edit1.maxlength:=20;
           edit1.text:=floattostr(otvet);
    g:=0;
    i:=0;
    z:=false;
    f1:=false;
    f2:=false;
    f3:=true;
 end
 else
     if (f8=true)  then begin
     form1.edit1.maxlength:=20;
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
InputRestriction;
end;

procedure TForm1.FactorialClick(Sender: TObject); // Факториал
  var
  e,g:real;
  i:integer;
  begin
  if z=false then begin
    e:=strtofloat(edit1.text);
    g:=1;
    if e<100 then begin
    if e<>0 then
       for i:=1 to trunc(e) do
           g:=g*i;
    edit1.maxlength:=20;
    edit1.text:=floattostr(g);
    InputRestriction;
    end
    else begin
         f9:=true;
         lock;
    end;
  end
  else
      lock;
end;

procedure TForm1.FormCreate(Sender: TObject);
  begin
  f4:=true;
end;

procedure TForm1.GGClick(Sender: TObject); // Фокус на edit1
begin
  edit1.setfocus;
end;

procedure TForm1.HelpClick(Sender: TObject); // Активна ли вторая форма
begin
  if form2.showing then
     creator.enabled:=false
  else
     creator.enabled:=true;
end;

procedure TForm1.lnbutClick(Sender: TObject);  //ln
var e:real;
begin
     e:=strtofloat(edit1.text);
     edit1.maxlength:=20;
     edit1.text:=floattostr(ln(e));
     f3:=true;
     InputRestriction;
end;

procedure TForm1.MClick(Sender: TObject); //Память
begin
 case (sender as Tbutton).caption of
      'M+':begin buffer:=buffer+strtofloat(edit1.text); buffer1:=floattostr(buffer); end;
      'M-':begin buffer:=buffer-strtofloat(edit1.text); buffer1:=floattostr(buffer); end;
      'MS':begin buffer:=strtofloat(edit1.text); buffer1:=floattostr(buffer); end;
      'MC':begin buffer:=0; buffer1:=''; end;
      'MR':edit1.text:=buffer1;
 end;
 if (buffer1<>'') then begin
    MR.enabled:=true;
    MC.enabled:=true;
 end
 else begin
    MR.enabled:=false;
    MC.enabled:=false;
 end;
 edit1.setfocus;
 f3:=true;
end;

procedure TForm1.NormalClick(Sender: TObject);   //Обычный вид калькулятора
begin
  form1.Width:=329;
  Normal.enabled:=false;
  Engineering.enabled:=True;
end;

procedure TForm1.EngineeringClick(Sender: TObject); //Инженерный вид калькулятора
begin
    form1.width:=460;
    Engineering.enabled:=false;
    Normal.enabled:=True;
end;

procedure TForm1.PercentClick(Sender: TObject);  //Процент
var
temp: double;
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

procedure TForm1.PibutClick(Sender: TObject);  //Число Пи
var e:real;
begin
  e:=pi;
  edit1.maxlength:=20;
  edit1.text:=floattostr(e);
  F3:=true;
  InputRestriction;
end;

end.

