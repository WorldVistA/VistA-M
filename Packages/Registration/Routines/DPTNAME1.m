DPTNAME1 ;BPOIFO/KEITH - NAME STANDARDIZATION ; 12 Aug 2002@20:20
 ;;5.3;Registration;**244,620,720**;Aug 13, 1993
 ;
NCEVAL(DGC,DGX) ;Evaluate name component entry values
 ;Input: DGC=name component (e.g. FAMILY, GIVEN, etc.)
 ;       DGX=input value for name
 ;
 Q:DGX="@"
 N DGM,DGL,DGI
 I DGX=""!($E(DGX)=U) Q
 D CVALID(DGC,DGX,.DGM)
 M DIR("?")=DGM("HELP") S DGI=$O(DIR("?",""),-1) I DGI D
 .S DIR("?")=DIR("?",DGI) K DIR("?",DGI)
 .Q
 I "???"[DGX Q
 I DGM("RESULT")="" D  Q
 .S DGI="" F  S DGI=$O(DGM("ERROR",DGI)) Q:DGI=""  D
 ..I DGM("ERROR",DGI)["''" S $P(DGM("ERROR",DGI),"'",2)=DGX
 ..W:DGI=1 ! W !,DGM("ERROR",DGI)
 ..Q
 .K DGX
 .Q
 I DGM("RESULT")'=DGX W "   (",DGM("RESULT"),")"
 S DGX=DGM("RESULT")
 Q
 ;
FAMILY ;Family name help text
 S DGM("LENGTH")="1-35"
 D HTEXT("family (last) name.",DGM("LENGTH"))
 S DGM("HELP",4)="Input values less than 3 characters in length must be all alpha characters."
 Q
 ;
GIVEN ;Given name help text
 S DGM("LENGTH")="1-25"
 D HTEXT("given (first) name.",DGM("LENGTH"))
 Q
 ;
MIDDLE ;Middle name help text
 S DGM("LENGTH")="1-25"
 D HTEXT("middle name.",DGM("LENGTH"))
 S DGM("HELP",4)="Middle names of 'NMI' and 'NMN' are prohibited."
 Q
 ;
PREFIX ;Name prefix help text
 S DGM("LENGTH")="1-10"
 D HTEXT("name prefix, such as MR or MS.",DGM("LENGTH"))
 Q
 ;
SUFFIX ;Name suffix help text
 S DGM("LENGTH")="1-10"
 D HTEXT("suffix(es), such as JR, SR, II, or III.",DGM("LENGTH"))
 Q
 ;
DEGREE ;Name degree help text
 S DGM("LENGTH")="1-10"
 D HTEXT("academic degree, such as BS, BA, MD, or PHD.",DGM("LENGTH"))
 Q
 ;
CVALID(DGC,DGX,DGM) ;Name component validation
 ; Input: DGC=name component (e.g. FAMILY, GIVEN, etc.)
 ;        DGX=input value to validate
 ;        DGM=array to return results and errors (pass by reference)
 ;
 ;Output: DGM array in the format:
 ;       DGM("ERROR",n)=error text (if any) 
 ;       DGM("HELP",n)=help text          
 ;       DGM("LENGTH")=field length in length (e.g. 3-30) 
 ;       DGM("RESULT")=transformed name value (null if invalid entry)
 ; 
 N DGL,DGF,DGI,DGR,DGMSG
 S DGF="FAMILY^GIVEN^MIDDLE^PREFIX^SUFFIX^DEGREE"
 S DGF=$P(DGF,DGC),DGF=$L(DGF,U)
 D @DGC  ;Set up length and help text 
 S DGL=+$P(DGM("LENGTH"),"-")_U_+$P(DGM("LENGTH"),"-",2)
 D CVALID^XLFNAME8(DGC,DGX,.DGM)
 Q
 ;
HTEXT(DGF,DGL) ;Generic help text
 ;Input: DGF=field name
 ;       DGL=field length
 S DGM("HELP",1)="Answer with this persons "_DGF
 S DGM("HELP",2)="The response must be "_DGL_" characters in length and may only contain"
 S DGM("HELP",3)="uppercase alpha characters, spaces, hyphens and apostrophes."
 Q
 ;
JUMP(DGI) ;Evaluate request to jump fields
 N DGX,DGY S DGX=$P($E(X,2,99)," ")
 I (U_DGCOM)'[(U_DGX) D  Q
 .W !,"While editing name components, only jumping to other components is allowed!",$C(7)
 .Q
 I (U_DGCOM_U)[(U_DGX_U) S DGI=$O(DGC(DGX,0)) Q
 S DGI=$O(DGC($O(DGC(DGX)),0))
 S DGY=$P(DGCOM,U,DGI)_$P(DGCX,U,DGI) W $P(DGY,DGX,2)
 Q
 ;
