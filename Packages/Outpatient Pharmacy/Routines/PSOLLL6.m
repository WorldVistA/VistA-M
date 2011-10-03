PSOLLL6 ;BHAM/BHW - LABEL TRAILER ;12/02/2002
 ;;7.0;OUTPATIENT PHARMACY;**120,141,135,162,161,305**;DEC 1997;Build 8
 ;
 I $G(PSOBLALL),$P(PPL,",",PI+1)'="" Q
 S PRCOPAY=$S('$D(PSOCPN):0,1:1)
NARR ;NARRATIVES
 N LC S (PSSIXFL,PSSEVFL,LENGTH,OUT)=0,PTEXT="" F I=4,6,7 S LC(I)=0
 I $G(PSOIO("RNI"))]"" X PSOIO("RNI")
 S XFONT=$E(PSOFONT,2,99)
 I $D(^PS(59,PSOSITE,6))!($D(^PS(59,PSOSITE,7))) S T=PNM_" "_SSNP_"  "_$G(PSONOW) D PRINT(T) S PSOY=PSOY+PSOYI
 F JJ=6,7 S TEXT="" D P(JJ)  S PSOY=PSOY+PSOYI Q:OUT
 I $G(PSOIO("CNI"))]"" X PSOIO("CNI")
 I $G(PSOCHAMP),$G(PSOTRAMT) S T="REMIT $"_PSOTRAMT_" TO AGENT CASHIER." D PRINT(T) G END
 I 'PRCOPAY G END
 S OUT=0,TEXT=""
 I $D(^PS(59,PSOSITE,4)) S T=PNM_" "_SSNP_"  "_$G(PSONOW) D PRINT(T) S PSOY=PSOY+PSOYI D P(4)
END ;
 D NPP
 K DIWF,DIWL,DIWR,EDT,LLL,PRCOPAY,PSNACNT,PSNOADDR,PSNOBOTH,PSNONARR,PSNOSUSP,PSNTHREE,PSOLGTH,PSOSD,PSOTRAIL,PSOTRDFN,PSSEVFL,PSSIXFL,PSSPCNT,PSSSRX,PSSUFLG,RXX,SPDATE,SPNUM,SPPL,TTT,VAADDR1,VADM,VAEL,VAPA,VASTREET,ZZ,ZZZ W @IOF
 Q
P(JJ) ;NARRATIVE PRINT CONTROL
 N TEXTLEN,PSOCNT
 S TEXTLEN=0,PSOCNT=0
 S ZZ=0 F  S ZZ=$O(^PS(59,PSOSITE,JJ,ZZ)) Q:'ZZ  S PSOCNT=PSOCNT+1 Q:PSOCNT>7  I $D(^(ZZ,0)) S TEXT=^(0),TEXTLEN=TEXTLEN+$L(TEXT) S:TEXTLEN>560 TEXTLEN=TEXTLEN-$L(TEXT),TEXT=$E(TEXT,1,560-TEXTLEN) Q:TEXT=""  D  Q:OUT
 . N IC
 . D STRT^PSOLLU1("SEC2",TEXT,.L)
 . I L(XFONT)>4.1 D  Q
 .. S IC=0 F J=1:1:$L(TEXT," ") D STRT^PSOLLU1("SEC2",$P(TEXT," ",J)_" ",.L) I L(XFONT)>4.1 S IC=1
 .. I IC D  Q:OUT
 ... F J=$L(TEXT):-1:1 S PTEXT=$E(TEXT,1,J) D STRT^PSOLLU1("SEC2",PTEXT,.L) D  Q:OUT
 .... I L(XFONT)<4.1 D PRINT(PTEXT) S LC(JJ)=LC(JJ)+1,TEXT=$E(TEXT,J+1,512),J=$L(TEXT)+1,PTEXT="" I PSOY>PSOYM S OUT=1
 .... Q
 ... Q
 .. I IC D:PTEXT]"" PRINT(PTEXT) S:PTEXT]"" LC(JJ)=LC(JJ)+1 S:PSOY>PSOYM OUT=1 Q
 .. F J=$L(TEXT," "):-1 S PTEXT=$P(TEXT," ",1,J) Q:OUT  Q:'$L(PTEXT)  D STRT^PSOLLU1("SEC2",PTEXT,.L) I L(XFONT)<4.1 D
 ... D PRINT(PTEXT) S LC(JJ)=LC(JJ)+1,TEXT=$P(TEXT," ",J+1,99) I PSOY>PSOYM S OUT=1
 ... ;Reset $L of TEXT +1 so J loop continues properly
 ... S J=$L(TEXT," ")+1
 ... Q
 .. Q
 . D PRINT(TEXT) S LC(JJ)=LC(JJ)+1,TEXT=""
 . I PSOY>PSOYM S OUT=1
 . Q
 I 'OUT I TEXT]"" D PRINT(TEXT) S LC(JJ)=LC(JJ)+1
 Q
PRINT(T) ;
 I $G(PSOIO(PSOFONT))]"" X PSOIO(PSOFONT)
 I $G(PSOIO("ST"))]"" X PSOIO("ST")
 W T,!
 I $G(PSOIO("ET"))]"" X PSOIO("ET")
 Q
 ;
NPP ; Notice of Privacy Practices
 N SKP S SKP=LC(6)+LC(7)
 S PSOX=0 F I=SKP:-1:LC(4) D PRINT("")
 I SKP,'LC(4) D PRINT(""),PRINT("")
 D:SKP<16 PRINT("")
 S SKP=PSOYI*$S(PSOLAN=2:4,1:2)+PSOY I SKP>PSOYM Q
 I $G(PSOLAN)=2 D  Q
 . S T="La Notificacion relacionada con las Politicas de Privacidad del Departamento de Asuntos del Veterano, IB 10-163, contiene los" D PRINT(T)
 . S T="detalles acerca de sus derechos de privacidad y esta disponsible electronicamente en la siguiente direccion:" D PRINT(T)
 . S T="http://www1.va.gov/Health/.  Usted tambien puede conseguir una copia escribiendo a la Oficina de Privacidad del" D PRINT(T)
 . S T="Departamento de Asuntos de Salud del Veterano, (19F2), 810 Vermont Avenue NW, Washington, DC 20420." D PRINT(T)
 S T="The VA Notice of Privacy Practices, IB 10-163, which outlines your privacy rights, is available online at http://www1.va.gov/Health/" D PRINT(T)
 S T="or you may obtain a copy by writing the VHA Privacy Office (19F2), 810 Vermont Avenue NW, Washington, DC 20420." D PRINT(T)
 Q
