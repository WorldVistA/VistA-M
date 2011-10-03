XUMFPZL7 ;CIOFO-SF/RAM - Master File Param ZL7 ;8/14/00
 ;;8.0;KERNEL;**262,369**;Jul 10, 1995;Build 27
 ;
 ;
Z05 ; State (#5)
 ;
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZL7","SEQ",1.1,1)="ST"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZL7","SEQ",1.2,.01)="ST"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZL7","SEQ",1.4,2)="ST"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZL7","SEQ",1.5,.01)="ST"
 ;
 Q
 ;
Z49 ; Service/Section (#49)
 ;
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZL7","SEQ",1.1,.01)="ST"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZL7","SEQ",1.2,1)="ST"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZL7","SEQ",3,1.6)="ST"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZL7","SEQ",4,6)="ST"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZL7","SEQ",5,1.5)="ST"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZL7","SEQ",6,1.7)="ST"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZL7","SEQ",7,730)="ST"
 ;
 Q
 ;
ZAG ; Agency (#4.11)
 ;
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZL7","SEQ",1.1,.02)="ST"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZL7","SEQ",1.2,.01)="ST"
 ;
 Q
 ;
ZRN ; Routine (#9.8)
 ;
 S ^TMP("XUMF MFS",$J,"PARAM","MULT","ZL7",5)=5
 S ^TMP("XUMF MFS",$J,"PARAM","MULT","ZL7",6)=5
 ;
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZL7","SEQ",1,.01)="ST"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZL7","SEQ",2,6)="ST"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZL7","SEQ",3,7.1)="ST"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZL7","SEQ",4,7.2)="ST"
 ;
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZL7","SEQ",5,"FILE")=9.818
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZL7","SEQ",5,"FIELD")=.01
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZL7","SEQ",5,"DTYP")="ST"
 ;
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZL7","SEQ",6,"FILE")=9.818
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZL7","SEQ",6,"FIELD")=2
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZL7","SEQ",6,"DTYP")="ST"
 ;
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZL7","SEQ",7,7.3)="ST"
 ;
 Q
 ;
NOTAB ;
 ;
 Q
 ;
