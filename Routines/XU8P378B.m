XU8P378B ;SFISC/SO-CREATE NEW-STYLE XREF ;8:38 AM  30 Aug 2005
 ;;8.0;KERNEL;**378**;Jul 10, 1995;Build 59
 ;
 N ZZXR,ZZRES,ZZOUT
 S ZZXR("FILE")=5
 S ZZXR("NAME")="ADUALC"
 S ZZXR("TYPE")="MU"
 S ZZXR("USE")="S"
 S ZZXR("EXECUTION")="R"
 S ZZXR("ACTIVITY")="IR"
 S ZZXR("SHORT DESCR")="MU"
 S ZZXR("DESCR",1)="This cross reference is used to maintain the dual REGULAR ""C"" cross "
 S ZZXR("DESCR",2)="reference on the ABBREVIATION(#1) field and the VA STATE CODE(#2) field "
 S ZZXR("DESCR",3)="and replaces the SET and KILL logic on the REGULAR traditional cross "
 S ZZXR("DESCR",4)="reference.  The REGULAR traditional cross references SET and KILL "
 S ZZXR("DESCR",5)="logic are set to a ""Q"" so look ups will not error out."
 S ZZXR("DESCR",6)=" "
 S ZZXR("DESCR",7)="5,1           ABBREVIATION           0;2 FREE TEXT (Required)"
 S ZZXR("DESCR",8)="              CROSS-REFERENCE:  5^C "
 S ZZXR("DESCR",9)="                                1)= Q"
 S ZZXR("DESCR",10)="                                2)= Q"
 S ZZXR("DESCR",11)="                                3)= Used in conjunction with the 'ADUALC' "
 S ZZXR("DESCR",12)="                                    xref."
 S ZZXR("DESCR",13)=" "
 S ZZXR("DESCR",14)="5,2           VA STATE CODE          0;3 FREE TEXT"
 S ZZXR("DESCR",15)="              CROSS-REFERENCE:  5^C "
 S ZZXR("DESCR",16)="                                1)= Q"
 S ZZXR("DESCR",17)="                                2)= Q"
 S ZZXR("DESCR",18)="                                3)= Used in conjunction with the 'ADUALC' "
 S ZZXR("DESCR",19)="                                    xref."
 S ZZXR("SET")="I ((X2(1)'="""")!(X1(1)'=X2(1))),X2(1)'="""" S ^DIC(5,""C"",X2(1),DA)="""" I ((X2(2)'="""")!(X1(2)'=X2(2))),X2(2)'="""" S ^DIC(5,""C"",X2(2),DA)="""" Q"
 S ZZXR("KILL")="I ((X2(1)="""")!(X1(1)'=X2(1))),X1(1)'="""" K ^DIC(5,""C"",X1(1),DA) I ((X2(2)="""")!(X1(2)'=X2(2))),X1(2)'="""" K ^DIC(5,""C"",X1(2),DA) Q"
 S ZZXR("WHOLE KILL")="K ^DIC(5,""C"")"
 S ZZXR("VAL",1)=1
 S ZZXR("VAL",1,"COLLATION")="F"
 S ZZXR("VAL",2)=2
 S ZZXR("VAL",2,"COLLATION")="F"
 D CREIXN^DDMOD(.ZZXR,"SW",.ZZRES,"ZZOUT")
 Q
