LRAPKOE1 ;DSS/FHS - AP LAB ORDER ENTRY CONT ;06/20/16  09:20
 ;;5.2;LAB SERVICE;**462**;Sep 27, 1994;Build 44
 ;Reference to ^DIC(130) Supported by ICR #5268
 ; Reference to DISP^SROSPLG supported by IA #893
 Q
DIQ(FILE,DA) ;
 K ARR,IEN
 D GETS^DIQ(FILE,DA_",",".01;.011;.02;.09;.14;.164;33;34;59;60","","ARR")
 S DA=DA_","
 I $O(ARR(FILE,DA,60,0)) D
 . W !,"Brief Clinical History:"
 S IEN=0 F  S IEN=$O(ARR(FILE,DA,60,IEN)) Q:IEN<1  D
 . W !,ARR(FILE,DA,60,IEN)
 I ARR(FILE,DA,33)]"" D
 . W !!,"Principle Diagnose: ",ARR(FILE,DA,33)
 I $O(ARR(FILE,DA,59,0)) D
 . W !!,"Operative Finding:"
 . S IEN=0 F  S IEN=$O(ARR(FILE,DA,60,IEN)) Q:IEN<1  D
 . . W !,ARR(FILE,DA,60,IEN)
 I ARR(FILE,DA,34)]"" D
 . W !!,"Post Operative Finding:",!,ARR(FILE,DA,34)
 W !
 Q
SPLG ;Get surgery case #
 ;S DFN=22850,LRDFN=485918,LRODT=3160419
 D ^LRAPKLG
 ;D:$G(SRTN) DIQ(130,SRTN)
 Q
ENDIQ(FILE,DA,DR) ;
 D EN^DIQ
 Q
