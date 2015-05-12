SCRPPAHS ;ALB/DJS - Position Assignment History Extract for PCMMR Data Validation; 04/18/14
 ;;5.3;Scheduling;**620**;AUG 13, 1993;Build 11
 ;
ENTER ; Entry point
 ; 
 ; Extract file will be a delimited text file (.TXT) that will provide information for PCMM data validation
 ; Delimiter is a pipe ("|") character
 ;
 ; FILE OUTPUT:
 ;
 ; STANUM - Station #
 ; POSAHIEN - IEN of Position Assignment History
 ; TPIEN - IEN of Team Position
 ; TMPOS - Team Position
 ; EFFDT - Effective Date
 ; PRACTIEN - IEN of Practitioner
 ; PRACTNR - Practitioner
 ; STATUS - Status
 ; STATRSN - Status Reason
 ; FTEEEQU - FTEE Equivalent
 ; DT4INACT - Date for Inactivation
 ; AVAILPOS - Available Positions
 ; MAXPT - Max # of Patients
 ; CURACTPT - Current Active Patients
 ; ADJPANEL - Adjusted Panel Size
 ; AUTINACT - Inactivated Automatically
 ; FTEEHST - FTEE History
 ;
 N SCMCPATH,SCMCHFS,SCMCERR,SCMCMODE,MSG,IOF
 N SITE,SCDATA,SCIENS,STANUM,POSAHIEN,TPIEN,TMPOS,EFFDT,PRACTIEN,PRACTNR,STATUS,DATE,ENTRY,POP
 N STATRSN,FTEEEQU,DT4INACT,AVAILPOS,MAXPT,CURACTPT,ADJPANEL,AUTINACT,FTEEHST,FTEEDAT,FTEEVAL
 S SITE=$$SITE^VASITE,STANUM=$P(SITE,"^",3)
 S SCMCPATH=$$DEFDIR^%ZISH(),SCMCHFS=STANUM_"_PCMMPOSITIONASSIGNMENTHISTORY.TXT",SCMCERR=0 U 0 W !!,SCMCPATH
 D HFSOPEN("SCMCRP",SCMCPATH,SCMCHFS,"W") I SCMCERR G END
 U IO
 D COLHDR,SETREC G END
 ;
SETREC ;$O through position assignment history file
 S POSAHIEN=0
 F  S POSAHIEN=$O(^SCTM(404.52,POSAHIEN)) Q:POSAHIEN=""!(POSAHIEN'?.N)  D
 .K SCDATA
 .S SCIENS=+$G(POSAHIEN)_","
 .D GETS^DIQ(404.52,SCIENS,".01;.02;.03;.04;.05;.07;.08;.09;.091;.096;.097;.098;.099;.11","IE","SCDATA","")
 .S TPIEN=$G(SCDATA(404.52,SCIENS,.01,"I"))
 .S TMPOS=$G(SCDATA(404.52,SCIENS,.01,"E"))
 .S EFFDT=$G(SCDATA(404.52,SCIENS,.02,"E"))
 .S PRACTIEN=$G(SCDATA(404.52,SCIENS,.03,"I"))
 .S PRACTNR=$G(SCDATA(404.52,SCIENS,.03,"E"))
 .S STATUS=$G(SCDATA(404.52,SCIENS,.04,"E"))
 .S STATRSN=$G(SCDATA(404.52,SCIENS,.05,"E"))
 .S FTEEEQU=$G(SCDATA(404.52,SCIENS,.09,"E"))
 .S DT4INACT=$G(SCDATA(404.52,SCIENS,.091,"E"))
 .S AVAILPOS=$G(SCDATA(404.52,SCIENS,.096,"E"))
 .S MAXPT=$G(SCDATA(404.52,SCIENS,.097,"E"))
 .S CURACTPT=$G(SCDATA(404.52,SCIENS,.098,"E"))
 .S ADJPANEL=$G(SCDATA(404.52,SCIENS,.099,"E"))
 .S AUTINACT=$G(SCDATA(404.52,SCIENS,.11,"I"))
 .S FTEEHST=$S($D(^SCTM(404.52,POSAHIEN,1,0)):1,1:"") I FTEEHST S ENTRY=0 D
 ..F  S ENTRY=$O(^SCTM(404.52,POSAHIEN,1,ENTRY)) Q:ENTRY=""!(ENTRY'?.N)  D
 ...S FTEEDAT=$P(^SCTM(404.52,POSAHIEN,1,ENTRY,0),"^"),DATE=$$FMTE^XLFDT(FTEEDAT,1)
 ...S FTEEVAL=$P(^SCTM(404.52,POSAHIEN,1,ENTRY,0),"^",2)
 ...S WRTLN(ENTRY)="|"_DATE_"|"_FTEEVAL
 ...Q
 .W STANUM_"|"_POSAHIEN_"|"_TPIEN_"|"_TMPOS_"|"_EFFDT_"|"_PRACTIEN_"|"_PRACTNR_"|"_STATUS_"|"_STATRSN_"|"_FTEEEQU_"|"_DT4INACT_"|"_AVAILPOS_"|"_MAXPT_"|"_CURACTPT_"|"_ADJPANEL_"|"_AUTINACT I 'FTEEHST W !
 .I FTEEHST F I=1:1 Q:'$D(WRTLN(I))  D
 ..W:I>1 STANUM_"|||||||||||||||" W WRTLN(I),!
 .K FTEEHST,WRTLN,I
 .Q
 Q
 ;
COLHDR ;Create column header for Position Assignment History extract file
 W "Station #|Pos. Assign. History IEN|Team Position IEN|Team Position|Effective Date|Practitioner IEN|Practitioner|Status|Status Reason|FTEE Equivalent|Date Flagged for Inactivation|"
 W "Available Positions|Max # of Patients|Current Active Patients|Adjusted Panel Size|Inactivated Automatically|FTEE Date|FTEE Value",!
 Q
 ;
END D HFSCLOSE("SCMCRP",SCMCHFS)
 I '+SCMCERR D  Q  ;Create pipe delimited output if no errors
 .S MSG=$NA(^TMP("SCMC",$J))
 ;Replace "##FFFF##" with Form Feeds - code needed for LINUX environments
 S I=0 F  S I=$O(^TMP("SCMC",$J,1,I)) Q:'I  D
 .S:^TMP("SCMC",$J,1,I)["##FFFF##" ^TMP("SCMC",$J,1,I)=$P(^TMP("SCMC",$J,1,I),"##FFFF##")_$C(13,12)_$P(^TMP("SCMC",$J,1,I),"##FFFF##",2)
 .S ^TMP("SCMC",$J,1,I)=^TMP("SCMC",$J,1,I)_$C(13)
 .S:^TMP("SCMC",$J,1,I)["$END" ^TMP("SCMC",$J,1,I)=""
 S MSG=$NA(^TMP("SCMC",$J))
 Q
 ;
HFSOPEN(HANDLE,SCMCPATH,SCMCHFS,SCMCMODE) ; Open File
 D OPEN^%ZISH(HANDLE,SCMCPATH,SCMCHFS,$G(SCMCMODE,"W")) D:POP  Q:POP
 .S SCMCERR=1,^TMP("SCMC",$J,1)="0^Unable to open file "
 S IOF="$$IOF^SCRPPAHS"   ;resets screen position and adds page break flag - added to deal with Linux environments.
 Q
 ;
HFSCLOSE(HANDLE,SCMHFS) ;Close HFS and unload data
 D CLOSE^%ZISH(HANDLE)
 Q
 ;
IOF() ;used to reset position and insert page break flag when @IOF is executed.
 S $X=0,$Y=0
 Q "##FFFF##"_$C(13,10)
 ;
