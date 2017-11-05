unit Unit1;

{$mode objfpc}{$H+}

interface

uses
Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
StdCtrls, LCLType, ExtCtrls, Buttons, ComCtrls, DbCtrls, Menus, Windows, Math, Unit2, Clipbrd;

type

  { TForm1 }

  TForm1 = class(TForm)
    But0: TButton;
    But1: TButton;
    Degree1: TButton;
    divbut: TButton;
    lnbut: TButton;
    Help1: TMenuItem;
    Editbf: TMenuItem;
    Copybuf: TMenuItem;
    Pastebuf: TMenuItem;
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
    procedure CopyandPastebufClick(Sender: TObject); //  Копировать и вставить
    procedure CreatorClick(Sender: TObject);
    procedure dellastsignClick(Sender: TObject); // Удаление последнего символа
    procedure InputRestriction(Sender: TObject);
    //Убирание каретки Begin
    procedure Edit1Click1(Sender: TObject);
    procedure edit1keyup(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
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
  Clipboard:Tclipboard;
  //Память
  buffer1:string;
  buffer:Extended;
  //end
  edit0:array[1..2] of Extended; // Для смены знака у степени числа
  chisla:array[1..255] of Extended; // Массив со всеми числами
  znaki:array[1..255] of char; // Массив со всеми знаками
  i,i1:integer; // Кол-во чисел и знаков
  t:real; // Для смены знака у степени числа
  f {Для блокировки кнопок}
  ,f1 {Чтобы число оставалось на экране до момента набора следующего}
  ,f2 {Для возвращения целого числа при обратной смене знака у степени числа}
  ,f3 {Чтобы число удалялось после выполнения действий, если с ним больше ничего не делают}
  ,f4,f5{Для смены знака во 2-м Editbf'e,если число не менялось}
  ,f6{Для вывода 0 во 2-й Editbf}
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
procedure TForm1.FormActivate(Sender: TObject);
begin
 HideCaret(Edit1.Handle);
  edit1.SelLength:=0;
  edit1.setfocus;
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
     if (length(e)=1) or (length(e)=2) and (e[1]='-') then
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

procedure TForm1.CopyandPastebufClick(Sender: TObject);   //Копировать и вставить
var s:string;
begin
  s:=edit1.text;
 case (sender as Tbutton).caption of
   'Копировать':Clipboard.Astext:=edit1.text;
   'Вставить':begin
     try
     edit1.CopyToclipboard;
     edit1.text:=floattostr(strtofloat(edit1.text)+1-1);
     except
     edit1.text:=s;
     end;
   end;
 end;
 f2:=false;
  f3:=true;
  edit1.SetFocus;
end;

procedure Tform1.InputRestriction(Sender: TObject); // Ограничение ввода в edit1
var p1:integer;
  p2:real;
  s:string;
Begin
  s:=form1.edit1.text;
  if form1.edit1.width<>468 then begin
  case length(s) of
       0..12:form1.edit1.font.Size:=39;
       13:form1.edit1.font.Size:=37;
       14:form1.edit1.font.Size:=33;
       15:form1.edit1.font.Size:=30;
       16:form1.edit1.font.Size:=28;
       17:form1.edit1.font.Size:=27;
       18:form1.edit1.font.Size:=25;
       19:form1.edit1.font.Size:=24;
       20:form1.edit1.font.Size:=23;
  end;
  for p1:=1 to length(s) do begin
          if s[p1]='1' then
             p2:=p2+0.5;
          if p2=3 then
             p2:=p2+0.5;
          if p2>6 then
             p2:=p2+0.5;
  end;
  form1.edit1.maxlength:=15;
  if (length(s) in [13..20]) and (p2>0) then begin
  form1.edit1.font.Size:=form1.edit1.font.Size+round(p2);
  p2:=0;
  end;
  end
  else begin
  form1.edit1.maxlength:=20;
  for p1:=1 to length(s) do begin
          if s[p1]='1' then
             p2:=p2+0.5;
          if p2=3 then
             p2:=p2+0.5;
          if p2>6 then
             p2:=p2+0.5;
  end;
    case length(s) of
       0..16:form1.edit1.font.Size:=39;
       17:form1.edit1.font.Size:=38;
       18:form1.edit1.font.Size:=36;
       19:form1.edit1.font.Size:=34;
       20:form1.edit1.font.Size:=32;
  end;
  end;
  end;

procedure changesign; // Смена вида знака
  begin
        case znaki[i] of
             'l':form1.gg.text:=form1.gg.text+'l';
             'm':form1.gg.text:=form1.gg.text+'m';
             'd':form1.gg.text:=form1.gg.text+'d';
             'v':form1.gg.text:=form1.gg.text+'v';
             '^':form1.gg.text:=form1.gg.text+'^';
             '+':form1.gg.text:=form1.gg.text+'+';
             '-':form1.gg.text:=form1.gg.text+'−';
             '*':form1.gg.text:=form1.gg.text+'×';
             '/':form1.gg.text:=form1.gg.text+'÷';
        end;
  end;

procedure Myp; //Заполнение 2-го Editbf'а
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

procedure Tform1.Edit1KeyPress(Sender: TObject; var Key: char);  // Блокировка всех символов, невходящих в состав необходимых
var
but:Tbutton;
begin
  case key of
       '0':but:=but0;
       '1':but:=but1;
       '2':but:=but2;
       '3':but:=but3;
       '4':but:=but4;
       '5':but:=but5;
       '6':but:=but6;
       '7':but:=but7;
       '8':but:=but8;
       '9':but:=but9;
       '=',#13:but:=EqualSign;
       ',':but:=Comma;
  end;
  if (edit1.text<>'Ошибка!') and (edit1.text<>'Переполнение!') then
     if  (key in ['0'..'9','*','/','-','+',',','=',#8,#13,'%']) then begin
         case key of
           '+':but:=plus;
           '-':but:=MinusSign;
           '*':but:=MultiplicationSign;
           '/':but:=divisionSign;
           #8:but:=dellastsign;
           '%':but:=percent;
         end;
      end;
  but.enabled:=false;
  sleep(50);
  but.enabled:=true;
  but.click;
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
  form1.Pibut.enabled:=false;
  form1.modbut.enabled:=false;
  form1.divbut.enabled:=false;
  form1.factorial.enabled:=false;
  form1.Degree.enabled:=false;
  form1.Degree1.enabled:=false;
  form1.logbut.enabled:=false;
  form1.lnbut.enabled:=false;
  form1.sinbut.enabled:=false;
  form1.cosbut.enabled:=false;
  form1.tgbut.enabled:=false;
  form1.ctgbut.enabled:=false;
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
  f2:=false;
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
  form1.Pibut.enabled:=true;
  form1.modbut.enabled:=true;
  form1.divbut.enabled:=true;
  form1.factorial.enabled:=true;
  form1.Degree.enabled:=true;
  form1.Degree1.enabled:=true;
  form1.logbut.enabled:=true;
  form1.lnbut.enabled:=true;
  form1.sinbut.enabled:=true;
  form1.cosbut.enabled:=true;
  form1.tgbut.enabled:=true;
  form1.ctgbut.enabled:=true;
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
end;
 if buffer1='' then begin
 Form1.MC.enabled:=false;
 Form1.MR.enabled:=false;
 end;
end;

procedure Edit; // Чтобы число оставалось на экране до момента набора следующего
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
    Edit;
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
       znaki[i] := #0;
   end;
   i := 0;
   Edit1.text := '0';
   f2 := false;
   f3:=false;
   f4:=true;
   f5:=false;
   f6:=false;
   edit1.SetFocus;
   gg.clear;
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
  f2:=false;
  F3:=true;
  edit1.SetFocus;
end;

procedure TForm1.SquareClick(Sender: TObject); //Возведение в квадрат
var e:double;
begin
  Try
  e:=StrToFloat(edit1.text);
  e:=e*e;
  edit1.MaxLength:=20;
  Edit1.text:=floattostr(e);
  except
  f9:=true;
  lock;
  end;
  f2:=false;
  f3:=true;
  edit1.SetFocus;
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
  f2:=false;
  f3:=true;
  edit1.SetFocus;
end;

procedure TForm1.CeClick(Sender: TObject); // Отчистка неполная
  begin
      Edit1.text:='0';
      f2:=false;
      edit1.SetFocus;
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
end;

procedure TForm1.ChangeOfSignOfTheDegreeClick(Sender: TObject);  //Смена знака степени у числа
var
e:double;
begin
 if f2=false then
    edit0[1]:=strtofloat(edit1.text);
 if (edit1.text<>'0') and (edit1.text<>'0,') then begin
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
f3:=true;
edit1.SetFocus; // Фокус на edit1
 if (edit1.text='0') or (edit1.text='0,') then begin
    lock;
    f2:=false;
   end;
end;


procedure TForm1.CommaClick(Sender: TObject);  // Запятая
var e:string;
e1:double;
begin
  unlock;
  Edit;
  edit2;
   if (edit1.text='') then
        edit1.text:='0,'
   else begin
        e:=edit1.text;
        e1:=strtofloat(edit1.text);
        if (frac(e1) = 0) and (e[length(e)]<>',') then begin  // Проверка запятой
           edit1.maxlength:=16;
           Edit1.text:=edit1.Text+',';
        end;
   end;
  f3:=false;
  edit1.SetFocus;
end;


procedure TForm1.signs(Sender: TObject); // Действия
  begin
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
        'ª√x':begin if chisla[i]<0 then lock else znaki[i]:='v'; end;
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
try
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
except
f9:=true;
lock;
end;
f1:=false;
f2:=false;
f3:=true;
f4:=true;
f5:=false;
f7:=false;
end;

procedure TForm1.FactorialClick(Sender: TObject); // Факториал
  var
  e,g:real;
  i:integer;
  begin
  g:=strtofloat(edit1.text);
  if frac(g)=0 then begin
    e:=strtofloat(edit1.text);
    g:=1;
    try
    if e<>0 then
       for i:=1 to trunc(e) do
           g:=g*i;
    edit1.maxlength:=20;
    edit1.text:=floattostr(g);
    except
         f9:=true;
         lock;
    end;
  end
  else
      lock;
  f2:=false;
  f3:=true;
  edit1.SetFocus;
end;

procedure TForm1.FormCreate(Sender: TObject); // При запуске формы
  begin
  Clipboard:=Tclipboard.Create;
  HideCaret(Edit1.Handle);
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
     f2:=false;
     f3:=true;
     edit1.SetFocus;
end;

procedure TForm1.MClick(Sender: TObject); //Память
begin
 case (sender as Tbutton).caption of
      'M+':begin buffer:=buffer+strtofloat(edit1.text); buffer1:=floattostr(buffer); end;
      'M-':begin buffer:=buffer-strtofloat(edit1.text); buffer1:=floattostr(buffer); end;
      'MS':begin buffer:=strtofloat(edit1.text); buffer1:=floattostr(buffer); end;
      'MC':begin buffer:=0; buffer1:=''; end;
      'MR':begin edit1.text:=buffer1; f2:=false; end;
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
  GG.width:=334;
  edit1.width:=337;
  form1.Width:=329;
  Normal.enabled:=false;
  Engineering.enabled:=True;
  edit1.SetFocus;
end;

procedure TForm1.EngineeringClick(Sender: TObject); //Инженерный вид калькулятора
begin
    gg.width:=465;
    edit1.width:=468;
    form1.width:=460;
    Engineering.enabled:=false;
    Normal.enabled:=True;
    edit1.SetFocus;
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
  f2:=false;
  f3:=true;
  edit1.SetFocus; // Фокус на edit1
end;

procedure TForm1.PibutClick(Sender: TObject);  //Число Пи
var e:real;
begin
  e:=pi;
  edit1.maxlength:=20;
  edit1.text:=floattostr(e);
  f2:=false;
  F3:=true;
  edit1.SetFocus;
end;

end.

