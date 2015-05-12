SCRPTEAM ;ALB/DJS - Team Listing Extract for PCMMR Data Validation; 04/03/14
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
 ; TIEN - IEN of team
 ; TNAME - Name of Team
 ; TPURPIEN - Team Purpose IEN  POINTER TO TEAM PURPOSE FILE (#403.47)
 ; TPURP - Team Purpose 
 ; ACTASPC - Can Act as a PC Team == 0 or 1
 ; TINST - Institution Name
 ; STANUM - Station #  POINTER TO INSTITUTION FILE (#4)
 ; MAXPT - Max # of Patients
 ; CLS2ASGN - Close to Further Assignment == 0 or 1
 ; CURPTS - Current # of Patients
 ; CURSTAT - Current Status == Active or Inactive
 ; CUREFFDT - Current Effective Date
 ; CURACTDT - Current Activation Date
 ; CURINADT - Current Inactivation Date
 ;
 N SCMCPATH,SCMCHFS,SCMCERR,MSG,SCMCMODE,IOF,SCIENS,SITE,STANUM
 N SCDATA,TIEN,TNAME,TPURPIEN,TPURP,ACTASPC,TINST,MAXPT,CLS2ASGN,CURPTS,CURSTAT,CUREFFDT,CURACTDT,CURINADT
 S SITE=$$SITE^VASITE,STANUM=$P(SITE,"^",3)
 S SCMCPATH=$$DEFDIR^%ZISH(),SCMCHFS=STANUM_"_PCMMTEAM.TXT",SCMCERR=0 U 0 W !!,SCMCPATH
 D HFSOPEN("SCMCRP",SCMCPATH,SCMCHFS,"W") I SCMCERR G END
 U IO
 D COLHDR,SETREC G END
 ;
SETREC  ;$O through team file and find all teams
    S TIEN=0
 F  S TIEN=$O(^SCTM(404.51,TIEN)) Q:TIEN=""!(TIEN'?.N)  D
 .K SCDATA
 .S SCIENS=+$G(TIEN)_","
 .D GETS^DIQ(404.51,SCIENS,".01;.02;.03;.05;.06;.07;.08;.09;.1;201;202;203;204;205","IE","SCDATA","")
 .S TNAME=$G(SCDATA(404.51,SCIENS,.01,"E"))
 .S TPURPIEN=$G(SCDATA(404.51,SCIENS,.03,"I"))
 .S TPURP=$G(SCDATA(404.51,SCIENS,.03,"E"))
 .S ACTASPC=$G(SCDATA(404.51,SCIENS,.05,"E"))
 .S TINST=$G(SCDATA(404.51,SCIENS,.07,"E"))
 .S MAXPT=$G(SCDATA(404.51,SCIENS,.08,"E"))
 .S CLS2ASGN=$G(SCDATA(404.51,SCIENS,.1,"E"))
 .S CURPTS=$G(SCDATA(404.51,SCIENS,201,"E"))
 .S CURSTAT=$G(SCDATA(404.51,SCIENS,202,"E"))
 .S CUREFFDT=$G(SCDATA(404.51,SCIENS,203,"E"))
 .S CURACTDT=$G(SCDATA(404.51,SCIENS,204,"E"))
 .S CURINADT=$G(SCDATA(404.51,SCIENS,205,"E"))
 .W STANUM_"|"_TIEN_"|"_TNAME_"|"_TPURPIEN_"|"_TPURP_"|"_ACTASPC_"|"_TINST_"|"_MAXPT_"|"_CLS2ASGN_"|"_CURPTS_"|"_CURSTAT_"|"_CUREFFDT_"|"_CURACTDT_"|"_CURINADT,!
 Q
 ;
COLHDR ;Create column header for Team extract file
 W "Station #|Team IEN|Team Name|Team Purpose IEN|Team Purpose|Act as a PC Team?|Institution|Max # Patients|Close to Assignment|"
 W "Current # Patients|Current Status|Current Effective Date|Current Activation Date|Current Inactivation Date",!
 Q
 ;
END D HFSCLOSE("SCMCRP",SCMCHFS)
 N I
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
 N POP
 D OPEN^%ZISH(HANDLE,SCMCPATH,SCMCHFS,$G(SCMCMODE,"W")) D:POP  Q:POP
 .S SCMCERR=1,^TMP("SCMC",$J,1)="0^Unable to open file "
 S IOF="$$IOF^SCRPTEAM"   ;resets screen position and adds page break flag - added to deal with Linux environments.
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
