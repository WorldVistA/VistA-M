DPTNAME ;BPOIFO/KEITH - NAME STANDARDIZATION ; 27 Jan 2002 11:05 PM
 ;;5.3;Registration;**244,620**;Aug 13, 1993
 ;
NCEDIT(DFN,DGHDR,DG20NAME) ;Edit name components
 ;Input: DFN=patient ifn
 ;     DGHDR=1 to write components header (optional)
 ;  DG20NAME=array of name components (optional)
 ;Output: formatted name and DG20NAME components array if the user
 ;        specifies filing, DG20NAME=null otherwise
 ;
 N DIR,X,Y,DGCOMP,DGC,DGI,DGX,DGY,DGCOM
 N DGCL,DGCX,DGOUT,DGEDIT,%,DIE,DR,DA
 ;Initialize variables
START S DFN=+DFN,(DGOUT,DGEDIT)=0,DGCOMP=$D(DG20NAME)>9
 S DGCOM="FAMILY^GIVEN^MIDDLE^PREFIX^SUFFIX^DEGREE"
 S DGCX=" (LAST) NAME^ (FIRST) NAME^ NAME"
 S DGCL="1:35^1:25^1:25^1:10^1:10^1:10"
 ;Get patient name
 S DGX=$P($G(^DPT(DFN,0)),U) Q:DGX=""
 ;Get name component values from file #20
 I 'DGCOMP S DGCOMP=+$G(^DPT(DFN,"NAME"))_"," I DGCOMP D
 .D GETS^DIQ(20,DGCOMP,"1:6",,"DGCOMP")
 .I '$D(DGCOMP(20,DGCOMP)) S DGCOMP=0 Q
 .F DGI=1:1:6 S DGX($P(DGCOM,U,DGI))=DGCOMP(20,DGCOMP,DGI)
 .Q
 ;Parse name components from name value
 I 'DGCOMP D
 .D STDNAME^XLFNAME(.DGX,"C") S DGEDIT=1
 .S DGX("SUFFIX")=$$CLEANC^XLFNAME(DGX("SUFFIX"))
 .Q
 ;Prompt for name component edits
 N DTOUT,DUOUT,DIRUT,DGCOUT
 S DGCOUT=0 M DG20NAME=DGX
 S DIR("PRE")="D:X'=""@"" NCEVAL^DPTNAME1(DGCOMP,.X)"
 I $G(DGHDR) W !,"Patient name components--"
 F DGI=1:1:6 S DGC($P(DGCOM,U,DGI),DGI)=""
 F DGI=1:1:6 Q:DGOUT  D
AGAIN .S DGCOMP=$P(DGCOM,U,DGI)
 .S DIR("A")=DGCOMP_$P(DGCX,U,DGI)
 .S DIR(0)="FO^"_$P(DGCL,U,DGI)
 .S DIR("PRE")="D NCEVAL^DPTNAME1(DGCOMP,.X)"
 .S DIR("B")=$S($D(DG20NAME(DGCOMP)):DG20NAME(DGCOMP),1:$G(DGX(DGCOMP)))
 .K:'$L(DIR("B")) DIR("B")
ASK .D ^DIR I $D(DTOUT)!(X=U) S:(X=U) DGCOUT=1 S DGOUT=1 Q
 .I $A(X)=94 D JUMP^DPTNAME1(.DGI) G AGAIN
 .I X="@",DGI=1 W !,$C(7),"Family name cannot be deleted!" G ASK
 .I X="@" D  Q
 ..W "  (deletion indicated)" S DG20NAME(DGCOMP)=""
 ..S:DG20NAME(DGCOMP)'=$G(DGX(DGCOMP)) DGEDIT=1
 ..Q
 .Q:'$L(X)
 .S DG20NAME=X
 .I DGCOMP="SUFFIX" S DG20NAME=$$CLEANC^XLFNAME(DG20NAME)
 .S DG20NAME=$$FORMAT^XLFNAME7(DG20NAME,1,35,,3,,1,1)
 .I '$L(DG20NAME) W "  ??",$C(7) G ASK
 .W:DG20NAME'=X "   (",DG20NAME,")" S DG20NAME(DGCOMP)=DG20NAME
 .S:DG20NAME(DGCOMP)'=$G(DGX(DGCOMP)) DGEDIT=1
 .Q
 Q:'DGEDIT ""
 Q:DGOUT&'DGCOUT ""
 ;Reconstruct name
 S DG20NAME=$$NAMEFMT^XLFNAME(.DG20NAME,"F","CFL30")
 ;Format the .01 value
 M DGY=DG20NAME
 S DG20NAME=$$FORMAT^XLFNAME7(.DGY,3,30,,2)
 ;Check the length
 I $L(DG20NAME)<3 D  G START
 .W !,"Invalid values to file, full name must be at least 3 characters!",$C(7)
 .K DG20NAME,DGX,DGCOMP Q
 ;File new name value
CONF W !,"Ok to file '",DG20NAME,"' and its name components"
 S %=1 D YN^DICN
 I '% W !,"Indicate if the edits to the name and its components should be filed." G CONF
 I %'=1 K DG20NAME S DG20NAME="" Q DG20NAME
 I '$$CONF1(DG20NAME) K DG20NAME S DG20NAME=""
 Q DG20NAME
 ;
CONF1(DPTX) ;Confirm if single name value is ok.
 ;Input: DPTX=name value
 N %
 Q:$E($P(DPTX,",",2))?1U 1
 W !!?5,$C(7),"WARNING: Do not enter single name values for patients (no given or"
 W !?5,"         first name) unless this is actually their legal name!!!",$C(7)
RC W !!,"Are you sure you want to enter the patient name in this manner"
 S %=2 D YN^DICN S %=$S(%<0!(%=2):-1,%=1:1,1:0) I '% W !?6,"Specify 'YES' to enter a single name value, or 'NO' to discontinue." G RC
 W !
 Q %=1
