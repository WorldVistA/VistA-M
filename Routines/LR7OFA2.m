LR7OFA2 ;slc/dcm - Process messages from OE/RR for AP ;8/11/97
 ;;5.2;LAB SERVICE;**121,187**;Sep 27, 1994
 ;
NTE ;Process AP Order comments from OE/RR
 S X=$D(STARTDT)&($D(TYPE))&($D(SAMP))&($D(SPEC))&($D(LRSX))
 I 'X Q  ;Trying to add comments to undefined test array in ^TMP
 I '$D(^TMP("OR",$J,"LROT",STARTDT,TYPE,SAMP,LRSX)) Q  ;Trying to add comments to undefined test array in ^TMP
 S:'$D(^TMP("OR",$J,"COM",STARTDT,TYPE,SAMP,LRSX)) ^(LRSX)=0 S LINES=^(LRSX)
 S LINES=LINES+1,^TMP("OR",$J,"COM",STARTDT,TYPE,SAMP,LRSX,LINES)=$P(LRXMSG,"|",4),^TMP("OR",$J,"COM",STARTDT,TYPE,SAMP,LRSX)=LINES
 Q
