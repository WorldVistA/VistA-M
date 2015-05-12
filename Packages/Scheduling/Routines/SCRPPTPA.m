SCRPPTPA ;ALB/DJS - Patient Team Position Assignment Extract for PCMMR Data Validation; 04/11/14
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
 ; PTPAIEN - IEN of Patient Team Position Assignment
 ; PTASGIEN - IEN of Patient Team Assignment
 ; PTASGN - Patient Team Assignment
 ; TMPOSIEN - IEN of Team Position
 ; TMPOS - Team Position
 ; POSASDT - Position Assigned Date
 ; POUNADT - Position Unassigned Date
 ; PCROLE - PC Role
 ; STATUS - Status
 ; EXTAUINA - Extend Automatic Inactivation
 ; EXTCMMNT - Extension Comment
 ; DT4INACT - Date Flagged for Inactivation
 ; SCHINADT - Scheduled Inactivation Date
 ; EXTBYIEN - IEN of Extended By value (ptr. to New Person file #200)
 ; EXTENDBY - Extended By
 ; DTDISINA - Date Disinactivated
 ;
 N SCMCPATH,SCMCHFS,SCMCERR,SCMCMODE,MSG,IOF,SITE
 N SCDATA,SCIENS,STANUM,PTPAIEN,PTASGIEN,PTASGN,TMPOSIEN,TMPOS,POSASDT,POUNADT
 N PCROLE,STATUS,EXTAUINA,EXTCMMNT,DT4INACT,SCHINADT,EXTBYIEN,EXTENDBY,DTDISINA
 S SITE=$$SITE^VASITE,STANUM=$P(SITE,"^",3)
 S SCMCPATH=$$DEFDIR^%ZISH(),SCMCHFS=STANUM_"_PCMMPATIENTTEAMPOSITIONASSIGNMENT.TXT",SCMCERR=0 U 0 W !!,SCMCPATH
 D HFSOPEN("SCMCRP",SCMCPATH,SCMCHFS,"W") I SCMCERR G END
 U IO
 D COLHDR,SETREC G END
 ;
SETREC  ;$O through patient team position assignment file
    S PTPAIEN=0
 F  S PTPAIEN=$O(^SCPT(404.43,PTPAIEN)) Q:PTPAIEN=""!(PTPAIEN'?.N)  D
 .K SCDATA
 .S SCIENS=+$G(PTPAIEN)_","
 .D GETS^DIQ(404.43,SCIENS,".01;.02;.03;.04;.05;.12;.13;.14;.15;.159;.16;.17","IE","SCDATA","")
 .S PTASGIEN=$G(SCDATA(404.43,SCIENS,.01,"I"))
 .S PTASGN=$G(SCDATA(404.43,SCIENS,.01,"E"))
 .S TMPOSIEN=$G(SCDATA(404.43,SCIENS,.02,"I"))
 .S TMPOS=$G(SCDATA(404.43,SCIENS,.02,"E"))
 .S POSASDT=$G(SCDATA(404.43,SCIENS,.03,"E"))
 .S POUNADT=$G(SCDATA(404.43,SCIENS,.04,"E"))
 .S PCROLE=$G(SCDATA(404.43,SCIENS,.05,"E"))
 .S STATUS=$G(SCDATA(404.43,SCIENS,.12,"E"))
 .S EXTAUINA=$G(SCDATA(404.43,SCIENS,.13,"E"))
 .S EXTCMMNT=$G(SCDATA(404.43,SCIENS,.14,"E"))
 .S DT4INACT=$G(SCDATA(404.43,SCIENS,.15,"E"))
 .S SCHINADT=$G(SCDATA(404.43,SCIENS,.159,"E"))
 .S EXTBYIEN=$G(SCDATA(404.43,SCIENS,.16,"I"))
 .S EXTENDBY=$G(SCDATA(404.43,SCIENS,.16,"E"))
 .S DTDISINA=$G(SCDATA(404.43,SCIENS,.17,"E"))
 .W STANUM_"|"_PTPAIEN_"|"_PTASGIEN_"|"_PTASGN_"|"_TMPOSIEN_"|"_TMPOS_"|"_POSASDT_"|"_POUNADT_"|"_PCROLE_"|"_STATUS_"|"_EXTAUINA_"|"_EXTCMMNT_"|"_DT4INACT_"|"_SCHINADT_"|"_EXTBYIEN_"|"_EXTENDBY_"|"_DTDISINA,!
 Q
 ;
COLHDR ;Create column header for Patient Team Position Assignment extract file
 W "Station #|Pt. Team Pos. Assign. IEN|Patient Team Assignment IEN|Patient Team Assignment|Team Position IEN|Team Position|Position Assigned Date|Position Unassigned Date|PC Role|"
 W "Status|Extend Automatic Inactivation|Extension Comment|Date Flagged for Inactivation|Scheduled Inactivation Date|Extended By IEN|Extended By|Date Disinactivated",!
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
 S IOF="$$IOF^SCRPPTPA"   ;resets screen position and adds page break flag - added to deal with Linux environments.
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
