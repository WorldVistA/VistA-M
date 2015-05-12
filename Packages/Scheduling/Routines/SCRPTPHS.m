SCRPTPHS ;ALB/DJS - Team Position History Extract for PCMMR Data Validation; 04/10/14
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
 ; TPHIEN - IEN of Team Position History file
 ; TPIEN - IEN of Team Position
 ; TPOS - Name of Team Position
 ; EFFDT - Effective Date
 ; STATUS - Status
 ; STATRSN - Status Reason
 ;
 N SCMCPATH,SCMCHFS,SCMCERR,SCMCMODE,MSG,IOF,SITE
 N SCDATA,SCIENS,STANUM,TPHIEN,TPIEN,TPOS,EFFDT,STATUS,STATRSN
 S SITE=$$SITE^VASITE,STANUM=$P(SITE,"^",3)
 S SCMCPATH=$$DEFDIR^%ZISH(),SCMCHFS=STANUM_"_PCMMTEAMPOSITIONHISTORY.TXT",SCMCERR=0 U 0 W !!,SCMCPATH
 D HFSOPEN("SCMCRP",SCMCPATH,SCMCHFS,"W") I SCMCERR G END
 U IO
 D COLHDR,SETREC G END
 ;
SETREC  ;$O through Team Position History file and find all team positions
    S TPHIEN=0
 F  S TPHIEN=$O(^SCTM(404.59,TPHIEN)) Q:TPHIEN=""!(TPHIEN'?.N)  D
 .K SCDATA
 .S SCIENS=+$G(TPHIEN)_","
 .D GETS^DIQ(404.59,SCIENS,".01;.02;.03;.04","IE","SCDATA","")
 .S TPIEN=$G(SCDATA(404.59,SCIENS,.01,"I"))
 .S TPOS=$G(SCDATA(404.59,SCIENS,.01,"E"))
 .S EFFDT=$G(SCDATA(404.59,SCIENS,.02,"E"))
 .S STATUS=$G(SCDATA(404.59,SCIENS,.03,"E"))
 .S STATRSN=$G(SCDATA(404.59,SCIENS,.04,"E"))
 .W STANUM_"|"_TPHIEN_"|"_TPIEN_"|"_TPOS_"|"_EFFDT_"|"_STATUS_"|"_STATRSN,!
 Q
 ;
COLHDR ;Create column header for Team Position History extract file
 W "Station #|Team Position History IEN|Team Position IEN|Team Name|Effective Date|Status|Status Reason",!
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
 S IOF="$$IOF^SCRPTPHS"   ;resets screen position and adds page break flag - added to deal with Linux environments.
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
