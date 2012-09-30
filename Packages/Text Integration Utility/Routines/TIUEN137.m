TIUEN137 ; SLC/MAM - Environment Check Rtn for TIU*1*137;6/3/03
 ;;1.0;Text Integration Utilities;**137**;Jun 20, 1997
MAIN ; Check environment
 ; -- Set data for DDEFs to export:
 D SETXTMP
 ; -- Check for potential DDEF duplicates at site:
 N TIUDUPS
 D TIUDUPS(.TIUDUPS)
 ; -- If potential duplicates exist, abort install:
 I 'TIUDUPS W !,"Document Definitions look OK." Q
 S XPDABORT=1 W !,"Aborting Install..."
 Q
 ;
SETXTMP ; Set up ^XTMP global
 S ^XTMP("TIU137",0)=3031201_U_DT
 ; -- Set basic data for new DDEFS into ^XTMP.
 ;    Reference DDEFS by NUMBER.
 ;    Number parent-to-be BEFORE child.
 ; -- DDEF Number 1:
 S ^XTMP("TIU137","BASICS",1,"NAME")="LR LABORATORY REPORTS"
 S ^XTMP("TIU137","BASICS",1,"INTTYPE")="CL"
 ; -- DDEF Number 2:
 S ^XTMP("TIU137","BASICS",2,"NAME")="LR ANATOMIC PATHOLOGY"
 S ^XTMP("TIU137","BASICS",2,"INTTYPE")="DC"
 ; -- DDEF Number 3:
 S ^XTMP("TIU137","BASICS",3,"NAME")="LR AUTOPSY REPORT"
 S ^XTMP("TIU137","BASICS",3,"INTTYPE")="DOC"
 ; -- DDEF Number 4:
 S ^XTMP("TIU137","BASICS",4,"NAME")="LR CYTOPATHOLOGY REPORT"
 S ^XTMP("TIU137","BASICS",4,"INTTYPE")="DOC"
 ; -- DDEF Number 5:
 S ^XTMP("TIU137","BASICS",5,"NAME")="LR ELECTRON MICROSCOPY REPORT"
 S ^XTMP("TIU137","BASICS",5,"INTTYPE")="DOC"
 ; -- DDEF Number 6:
 S ^XTMP("TIU137","BASICS",6,"NAME")="LR SURGICAL PATHOLOGY REPORT"
 S ^XTMP("TIU137","BASICS",6,"INTTYPE")="DOC"
 Q
 ;
TIUDUPS(TIUDUPS,SILENT) ; Set array of potential duplicates
 N NUM S (NUM,TIUDUPS)=0
 F  S NUM=$O(^XTMP("TIU137","BASICS",NUM)) Q:'NUM  D
 . ; -- When looking for duplicates, ignore DDEF if
 . ;      previously created by this patch:
 . Q:$G(^XTMP("TIU137","BASICS",NUM,"DONE"))
 . ; -- If site already has DDEF w/ same Name & Type as one
 . ;    we are exporting, set its number into array TIUDUPS:
 . N NAME,TYPE,TIUY S TIUY=0
 . S NAME=^XTMP("TIU137","BASICS",NUM,"NAME"),TYPE=^XTMP("TIU137","BASICS",NUM,"INTTYPE")
 . F  S TIUY=$O(^TIU(8925.1,"B",NAME,TIUY)) Q:+TIUY'>0  D
 . . I $P($G(^TIU(8925.1,+TIUY,0)),U,4)=TYPE S TIUDUPS(NUM)=+TIUY,TIUDUPS=1
 ; -- Write list of duplicates:
 I +TIUDUPS,'$G(SILENT) D
 . W !,"You already have the following Document Definitions exported by this patch."
 . W !,"I don't want to overwrite them. Please change their names so they no longer"
 . W !,"match the exported ones, or if you are not using them, delete them."
 . W !!,"If you change the name of a Document Definition, remember to update its Print"
 . W !,"Name, as well. For help, contact National VistA Support."
 . N NUM S NUM=0
 . F  S NUM=$O(TIUDUPS(NUM)) Q:'NUM  D
 . . W !?5,^XTMP("TIU137","BASICS",NUM,"NAME")
 Q
