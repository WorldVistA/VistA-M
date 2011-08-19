LRUG ;AVAMC/REG/CYM - GET LRDFN ;9/3/97  09:18 ;
 ;;5.2;LAB SERVICE;**90**;Sep 27, 1994
 S LRA=X I $D(LRT),LRT="A" D AUTO Q:'$D(X)
 N LRSAVE S LRSAVE=$G(DIC),LRSAVE(0)=$G(DIC(0)),LRSAVE("W")=$G(DIC("W"))
 K DIC S DIC(0)="EMZ",X=LRA W !!,"PATIENT: " D EN1^LRDPA K DIC,LRA I LRDFN>0 S A=^LR(LRDFN,0),B=^DIC($P(A,"^",2),0,"GL"),A=$P(A,"^",3),A=@(B_A_",0)"),LRD(1)=$P(A,"^",3),LRP(1)=$P(A,"^") W !,LRP(1)
 S DIC=LRSAVE,DIC(0)=LRSAVE(0),DIC("W")=LRSAVE("W")
 S LRA="" I LRDFN<1 K X Q
 I $D(LRT),LRT="A" D CK Q:'$D(X)
 S X=LRDFN Q
CK I LRP(0)'=LRP(1) W $C(7),!!,LRP(0)," does not equal ",LRP(1)," " K X Q
 I LRD'=LRD(1) W $C(7),!!,"Dates of birth are different" K X Q
 Q
AUTO ;Check for autologous donor in patient file
 Q:X["?"  W !!,"Donor:",LRP," DOB:",LRB W:LRS(2)]"" " SSN:",LRS(2)
 I '$D(^DPT("B",LRP(0))) W $C(7),!,LRP(0)," not entered in PATIENT FILE" K X
 Q
