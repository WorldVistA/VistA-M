LR311PST ;DALOI/WTY,HOIFO/FT-CREATE NEW-STYLE XREF ;11/22/04  10:13
 ;;5.2;LAB SERVICE;**311**;Sep 27, 1994
 ;
 ; This routine uses the following IAs:
 ; <None>
 ;
EN ; Driver
 D SP,CY
 Q
SP ; Create new cross-reference on subfile 63.12, field #10 (ORGAN/TISSUE)
 N LRXR,LRRES,LROUT
 S LRXR("FILE")=63.12
 S LRXR("NAME")="AC"
 S LRXR("TYPE")="MU"
 S LRXR("USE")="A"
 S LRXR("EXECUTION")="F"
 S LRXR("ACTIVITY")=""
 S LRXR("SHORT DESCR")="Notify Women's Health of SNOMED change"
 S LRXR("DESCR",1)="This MUMPS cross reference calls SNOMED^LRWOMEN any time a change to a SNOMED"
 S LRXR("DESCR",2)="code is made.  The SNOMED line tag notifies the Women's Health package that"
 S LRXR("DESCR",3)="a SNOMED change has been made on an already verified pathology report for a"
 S LRXR("DESCR",4)="female patient."
 S LRXR("SET")="Q:$D(DIU(0))  D SNOMED^LRWOMEN"
 S LRXR("KILL")="Q"
 S LRXR("VAL",1)=.01
 S LRXR("VAL",1,"SUBSCRIPT")=1
 S LRXR("VAL",1,"COLLATION")="F"
 D CREIXN^DDMOD(.LRXR,"kW",.LRRES,"LROUT")
 Q
CY ; Create new cross-reference on subfile 63.912, field #1 (CYTOPATH ORGAN/TISSUE)
 N LRXR,LRRES,LROUT
 S LRXR("FILE")=63.912
 S LRXR("NAME")="AC"
 S LRXR("TYPE")="MU"
 S LRXR("USE")="A"
 S LRXR("ACTIVITY")=""
 S LRXR("EXECUTION")="F"
 S LRXR("SHORT DESCR")="Notify Women's Health of SNOMED change"
 S LRXR("DESCR",1)="This MUMPS cross reference calls SNOMED^LRWOMEN any time a change to a SNOMED"
 S LRXR("DESCR",2)="code is made.  The SNOMED line tag notifies the Women's Health package that a"
 S LRXR("DESCR",3)="SNOMED change has been made on an already verified pathology report for a"
 S LRXR("DESCR",4)="female patient."
 S LRXR("SET")="Q:$D(DIU(0))  D SNOMED^LRWOMEN"
 S LRXR("KILL")="Q"
 S LRXR("VAL",1)=.01
 S LRXR("VAL",1,"SUBSCRIPT")=1
 S LRXR("VAL",1,"COLLATION")="F"
 D CREIXN^DDMOD(.LRXR,"kW",.LRRES,"LROUT")
 Q
