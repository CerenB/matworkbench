function surfout=matwb_project(Meshpath,Vol,varargin)
% creating the shape data via workbench
 %%% wb_command -volume-to-surface-mapping fakeBrain.nii.gz ....
 %%%    Conte69.L.midthickness.32k_fs_LR.surf.gii fakeBrainL.shape.gii
 %%%    -trilinear  -cubic  -enclosing
 if isempty(varargin)
    ProjMethod=' -enclosing';
 else
    ProjMethod=varargin{1};
 end

surfout=[];
for i=1:size(Vol,1)
    
FileIn=Vol(i,:);
[Path,NameFile,~]=fileparts(FileIn);

% projecting to the Left
FileOutL=fullfile(Path,[NameFile '.L.shape.gii']);
ProjL=fullfile(Meshpath,'Conte69.L.midthickness.164k_fs_LR.surf.gii ');
unix(['wb_command -volume-to-surface-mapping ' FileIn ' ' ...
    ProjL  ' ' FileOutL ' ' ProjMethod]);

% projecting to the right
FileOutR=fullfile(Path,[NameFile '.R.shape.gii']);
ProjR=fullfile(Meshpath,'Conte69.R.midthickness.164k_fs_LR.surf.gii ');
unix(['wb_command -volume-to-surface-mapping ' FileIn ' ' ...
    ProjR ' ' FileOutR ' ' ProjMethod]); 

surfout=char(surfout,FileOutR,FileOutL);
end

surfout=surfout(2:end,:);

    

