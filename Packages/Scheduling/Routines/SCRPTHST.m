SCRPTHST ;ALB/DJS - Team History Extract for PCMMR Data Validation; 04/10/14
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
 ; TIEN - IEN of Team
 ; TNAME - Name of Team
 ; EFFDT - Effective Date
 ; STATUS - Status
 ; STATRSN - Status Reason
 ;
 N SCMCPATH,SCMCHFS,SCMCERR,MSG,SCMCMODE,IOF,SITE
 N SCDATA,SCIENS,STANUM,TIEN,TNAME,EFFDT,STATUS,STATRSN
 S SITE=$$SITE^VASITE,STANUM=$P(SITE,"^",3)
 S SCMCPATH=$$DEFDIR^%ZISH(),SCMCHFS=STANUM_"_PCMMTEAMHISTORY.TXT",SCMCERR=0 U 0 W !!,SCMCPATH
 D HFSOPEN("SCMCRP",SCMCPATH,SCMCHFS,"W") I SCMCERR G END
 U IO
 D COLHDR,SETREC G END
 ;
SETREC  ;$O through Team History file and find history for all teams
    S TIEN=0
 F  S TIEN=$O(^SCTM(404.58,TIEN)) Q:TIEN=""!(TIEN'?.N)  D
 .K SCDATA
 .S SCIENS=+$G(TIEN)_","
 .D GETS^DIQ(404.58,SCIENS,".01;.02;.03;.04","IE","SCDATA","")
 .S TNAME=$G(SCDATA(404.58,SCIENS,.01,"E"))
 .S EFFDT=$G(SCDATA(404.58,SCIENS,.02,"E"))
 .S STATUS=$G(SCDATA(404.58,SCIENS,.03,"E"))
 .S STATRSN=$G(SCDATA(404.58,SCIENS,.04,"E"))
 .W STANUM_"|"_TIEN_"|"_TNAME_"|"_EFFDT_"|"_STATUS_"|"_STATRSN,!
 Q
 ;
COLHDR ;Create column header for Team History extract file
 W "Station #|Team History IEN|Team Name|Effective Date|Status|Status Reason",!
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
 S IOF="$$IOF^SCRPTHST"   ;resets screen position and adds page break flag - added to deal with Linux environments.
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
