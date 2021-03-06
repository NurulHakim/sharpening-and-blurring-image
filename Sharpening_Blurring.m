function varargout = Sharpening_Blurring(varargin)
% SHARPENING_BLURRING MATLAB code for Sharpening_Blurring.fig
%      SHARPENING_BLURRING, by itself, creates a new SHARPENING_BLURRING or raises the existing
%      singleton*.
%
%      H = SHARPENING_BLURRING returns the handle to a new SHARPENING_BLURRING or the handle to
%      the existing singleton*.
%
%      SHARPENING_BLURRING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHARPENING_BLURRING.M with the given input arguments.
%
%      SHARPENING_BLURRING('Property','Value',...) creates a new SHARPENING_BLURRING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Sharpening_Blurring_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Sharpening_Blurring_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Sharpening_Blurring

% Last Modified by GUIDE v2.5 14-May-2020 16:06:37

% Begin initialization code - DO NOT EDIT
%===================== File Bawaan GUI ===============================
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Sharpening_Blurring_OpeningFcn, ...
                   'gui_OutputFcn',  @Sharpening_Blurring_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
%==========================================================


% --- Executes just before Sharpening_Blurring is made visible.

%============= Dijalankan ketika program dimulai ==================

function Sharpening_Blurring_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Sharpening_Blurring (see VARARGIN)

clear global FileName;      % -> Agar setiap relog data dikosongkan (global FileName)
clear global var_gambar;    % -> Agar setiap relog data dikosongkan (global var_gambar)
handles.axes_gambar;        % -> set Icon Uolpad di awal mengisi axes_gambar
imshow('icon-upload-3.jpg');% -> image show file icon-upload-3.jpg

% Choose default command line output for Sharpening_Blurring
handles.output = hObject;   % -> Bawaan dari GUI Matlab

% Update handles structure
guidata(hObject, handles);  % -> Bawaan dari GUI Matlab

% UIWAIT makes Sharpening_Blurring wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.

% ======================= Bawaan GUI Matlab ============================

function varargout = Sharpening_Blurring_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_pilih_file.


%=============== Fungsi ketika tombol pilih file ditekan ============

function btn_pilih_file_Callback(hObject, eventdata, handles)

%pilih file
clear global FileName;      % -> Agar tidak error / menghapus FileName yang tersimpan
clear global var_gambar;    % -> Agar tidak error / menghapus FileName yang tersimpan

[FileName,user_cance]=imgetfile();  % -> Membuka jendela Open File / Image

%=== user_ance adalah ketika user tidak jadi / menutup jendela File / Image
if user_cance
    %=== membuat pop up peringatan ketika user tidak jadi memasukan file
    msgbox('Anda membatalkan upload file!','Peringatan','warn');
else
    %=== ketika user input gambar
    %=== membaca gambar dari FileName yang didapat dari file pilihan user
    var_gambar = imread(FileName);
    
    axes(handles.axes_gambar); % -> mendapat axes untuk dimasukan gambar
    imshow(var_gambar); % -> menampilkan image hasil browse pada axes yang didapat
    set(handles.er_blur, 'string', '');     % -> menghapus keterangan error 'belum upload
    set(handles.er_sharp, 'string', '');    % -> menghapus keterangan error 'belum upload
end

global var_gambar;  % -> membuat var_gambar menjadi global variable
global FileName;    % -> membuat FileNama menjadi global variable

% hObject    handle to btn_pilih_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_filter.
function btn_filter_Callback(hObject, eventdata, handles)

%filter blurring

% === Agar global variable dapat dipakai di function ini
global var_gambar;  % -> mengambil var_gambar dari global variable
global FileName;    % -> mengambil FileName dari global varable

% === jika FileNama kosong masuk ke else (artinya belum upload gambar)
if FileName
    % === kode blurring serta memasukannya ke figur
    pic2 = var_gambar;                  % -> mengambil file dari global variable
    
    figure, subplot(1,2,1), image(pic2), title('Original'); % -> memasukan gambar ori ke figur
    gaussianFilter = fspecial('gaussian', [7, 7], 5); % -> filter gaussian set
    
    % === memfilter gambar ori (pic2) dengan gaussian filter / blur
    gaussianPic = imfilter(pic2, gaussianFilter, 'symmetric', 'conv');
    % === memasukan hasil filter gaussian ke figur di subplot kanan
    subplot(1,2,2), image(gaussianPic), title('Blurring');
else
    % === mengisi keterangan jika gambar belum diinput
    set(handles.er_blur, 'string', 'Anda belum mengupload gambar');
    set(handles.er_sharp, 'string', ''); % -> menghapus keterangan pada error sharping
end


% hObject    handle to btn_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_sharp.
function btn_sharp_Callback(hObject, eventdata, handles)
%filter sharping
global var_gambar;  % -> mengambil var_gambar dari global variable
global FileName;    % -> mengambil FileName dari global vara

% === jika FileNama kosong masuk ke else (artinya belum upload gambar)
if FileName
    pic2 = var_gambar;          % -> mengambil file dari global variable
    sharpFilter = fspecial('unsharp');  % -> fungsi fspecial('unsharp')
    
    % === memasukan Gambar non filter (ori / pic2) ke figure
    figure, subplot(1,2,1), image(pic2), title('Original'); 
    
    sharp = imfilter(pic2, sharpFilter, 'replicate');   % -> memfilter gambar dengan sharpFilter
    subplot(1,2,2), image(sharp), title('Sharpened');   % -> memasukan hasil filter ke figure
else 
    % === mengisi keterangan jika gambar belum diinput
    set(handles.er_sharp, 'string', 'Anda belum mengupload gambar');
    set(handles.er_blur, 'string', ''); % -> menghapus keterangan pada error pada blur
end
% hObject    handle to btn_sharp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
