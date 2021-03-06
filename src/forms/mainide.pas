unit MainIde;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  ShellCtrls, LCLType, CodeEditor, IdeOutput, ProjectWizard;

type

  { TfrIDE }

  TfrIDE = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    miFormAppWizard: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    Separator2: TMenuItem;
    Separator1: TMenuItem;
    miOpenProject: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    pnOutput: TPanel;
    pnCodeEditor: TPanel;
    sddPath: TSelectDirectoryDialog;
    tvProjectStructure: TShellTreeView;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure miFormAppWizardClick(Sender: TObject);
    procedure miOpenProjectClick(Sender: TObject);
    procedure tvProjectStructureDblClick(Sender: TObject);
  private

  public

  end;

var
  frIDE: TfrIDE;

implementation

{$R *.lfm}

{ TfrIDE }

procedure TfrIDE.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  Answer, DialogStyle: integer;
begin
  DialogStyle := MB_ICONQUESTION + MB_YESNO;
  Answer := Application.MessageBox('Are you sure?', 'Confirmation', DialogStyle);
  if Answer = IDYES then
    Application.Terminate
  else
    Abort;

end;

procedure TfrIDE.FormCreate(Sender: TObject);
begin

end;

procedure TfrIDE.FormShow(Sender: TObject);
begin
  tvProjectStructure.Root := ExtractFilePath(Application.ExeName);
  frCodeEditor.Parent := pnCodeEditor;
  frCodeEditor.Align := alClient;
  frCodeEditor.BorderStyle := bsNone;
  frCodeEditor.Show;
  frIdeOutput.Parent := pnOutput;
  frIdeOutput.Align := alClient;
  frIdeOutput.BorderStyle := bsNone;
  frIdeOutput.Show;
end;

procedure TfrIDE.miFormAppWizardClick(Sender: TObject);
begin
  frProjectWizard.Show;
end;

procedure TfrIDE.miOpenProjectClick(Sender: TObject);
begin
  if sddPath.Execute then
  begin
    tvProjectStructure.Root := sddPath.FileName;
  end;
end;

procedure TfrIDE.tvProjectStructureDblClick(Sender: TObject);
begin
  frCodeEditor.OpenSamaFile(tvProjectStructure.Selected.GetTextPath);
end;

end.

