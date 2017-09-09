unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image5: TImage;
    Label1: TLabel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

{ TForm2 }


procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  Canclose:=Messagedlg('Вы, действительно, хотите закрыть эти ЧУДЕСНЫЕ картинки?',mtConfirmation, [mbyes,mbno],0)=mrYes
end;

end.

