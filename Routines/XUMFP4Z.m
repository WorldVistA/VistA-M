XUMFP4Z ;CIOFO-SF/RAM - Master File C/S Params INSTITUTION ;06/28/00
 ;;8.0;KERNEL;**416**;Jul 10, 1995;Build 5
 ;
 ;
 ; This routine sets up the parameters required by the INSTITUTION (#4)
 ; file for the Master File server mechanism.
 ;
 ;  ** This routine is not a supported interface -- use XUMFP **
 ;
 ;  See XUMFP for parameter list documentation
 ;
 ; ZIN -- VA Specific VHA Institution Segment sequence
 S ^TMP("XUMF MFS",$J,"PARAM","SEGMENT")="ZIN"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",1,.01)="ST"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",2,99)="ST"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",3,11)="ID"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",4,13)="CE^~FACILITY TYPE~VA"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",5,100)="ST"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",6,101)="ST"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",7,.02)="ST"
 ; associations -- VISN
 I '$P($G(^DIC(4,+IEN,99)),U,4) D
 .S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",8,"FILE")=4.014
 .S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",8,"FIELD")=1
 .S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",8,"DTYP")="CE^~VISN~VA"
 .; associations -- parent
 .S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",9,"FILE")=4.014
 .S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",9,"FIELD")="1"
 .S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",9,"DTYP")="ST"
 ; history -- old station number
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",10,"FILE")=4.999
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",10,"FIELD")=.01
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",10,"DTYP")="DT"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",11,"FILE")=4.999
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",11,"FIELD")=".06"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",11,"DTYP")="ST^^:99"
 ; history -- new station number
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",12,"FILE")=4.999
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",12,"FIELD")=.01
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",12,"DTYP")="DT"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",13,"FILE")=4.999
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",13,"FIELD")=".05"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",13,"DTYP")="ST^^:99"
 ; physical address
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",14.1,.01)="SAD"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",14.2,1.01)="ST"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",14.3,1.03)="ST"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",14.4,.02)="ST"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",14.5,1.04)="ST"
 ; mailing address
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",15.1,.01)="SAD"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",15.2,4.01)="ST"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",15.3,4.03)="ST"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",15.4,4.04)="ST"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",15.5,4.05)="ST"
 ; agency code
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",16,95)="CE^~AGENCY CODE~VA"
 ; npi
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",17,"FILE")=4.042
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",17,"FIELD")=.01
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",17,"DTYP")="DT"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",18,"FILE")=4.042
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",18,"FIELD")=.02
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",18,"DTYP")="NM"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",19,"FILE")=4.042
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",19,"FIELD")=.03
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",19,"DTYP")="ST"
 ; taxonomy
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",20,"FILE")=4.043
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",20,"FIELD")=.01
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",20,"DTYP")="ST"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",21,"FILE")=4.043
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",21,"FIELD")=.02
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",21,"DTYP")="ST"
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",22,"FILE")=4.043
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",22,"FIELD")=.03
 S ^TMP("XUMF MFS",$J,"PARAM","SEG","ZIN","SEQ",22,"DTYP")="ST"
 ;
 Q
 ;
