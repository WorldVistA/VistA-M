ECTASPC ;B'ham ISC/PTD-Space Survey by Service or Building Number ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;**6**;
 I '$D(^ENG("SP")) W *7,!!?29,"OPTION IS UNAVAILABLE!",!,"The 'Eng Space' File - #6928 is not loaded on your system.",!! S XQUIT="" Q
 I '$O(^ENG("SP",0)) W *7,!!,"'Eng Space' File - #6928 has not been populated on your system.",!! S XQUIT="" Q
 ;CHOOSE SORT BY FIELD: BUILDING NUMBER OR SERVICE
CHS W !!,"You may choose to SORT by:",!!,"1.  Building number.",!?5,"OR",!,"2.  Service.",!!,"Select a number (1 or 2): "
 R CHS:DTIME G:'$T!("^"[CHS) EXIT I CHS'?1N!(CHS<1)!(CHS>2) W !!,*7,"You MUST answer ""1"" or ""2""." G CHS
 ;IF CHS=2, THEN SORT BY SERVICE; ELSE SORT BY BUILDING NUMBER
DIP S DIC="^ENG(""SP"",",L=0,DHD="@" S BY=$S(CHS=2:"1.5",1:".5")
 S FLDS="""ROOM #: "";S1,.01,""SERVICE: "";C40,1.5,""FUNCTION: "";C1,2.5,""SQ.FT.: "";C40,NET SQ.FT.,""BLDG #: "";C1,.5"
 D EN1^DIP
EXIT K B,BY,CHS,DHD,DIC,ECT1,FLDS,L,P,X
 Q
 ;
