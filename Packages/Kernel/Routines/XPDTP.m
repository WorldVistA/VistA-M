XPDTP ;SFISC/RSD - Transport using a Packman Message ;09/23/96  13:54
 ;;8.0;KERNEL;**21,40,44**;Jul 05, 1995
 N DIFROM,DIR,DIRUT,DWPK,DWLW,DIC,I,J,XCN,XCNP,XMDISPI,XMDUN,XMDUZ,XMKEY,XMSCR,XMSUB,XMY,XMZ,X,Y,%
 S DIFROM=1,DIR(0)="F^3:65",DIR("A")="Subject",DIR("?")="Enter the subject for this Packman Message"
 D ^DIR Q:$D(DIRUT)
 S XMSUB=Y,XMDUZ=+DUZ
 K ^TMP("XMP",$J)
 W !,"Please enter description of Packman Message",!
 S DWPK=1,DWLW=75,DIC="^TMP(""XMP"",$J," D EN^DIWE
 D KIDS^XMP
 S XCNP=XCNP+1,^XMB(3.9,XMZ,2,XCNP,0)="$KID "_XPDNM,XCNP=XCNP+1
 ;for multiple packages, this would be a for loop
 D GS K:'$G(^XTMP("XPDT",XPDA)) ^(XPDA)
 S $P(^XMB(3.9,XMZ,2,0),U,3,4)=XCNP_U_XCNP
 ;secure message & then send
 D ^XMASEC Q:$D(DTOUT)!$D(DUOUT)  D EN3^XMD
 K ^TMP("XMP",$J)
 Q
GS N GR,GCK,GL
 S GCK="^XTMP(""XPDT"","_XPDA,GR=GCK_")",GCK=GCK_",",GL=$L(GCK)
 ;INSTALL NAME line will mark the begining of global for all lines until
 ;the next INSTALL NAME
 S ^XMB(3.9,XMZ,2,XCNP,0)="**INSTALL NAME**",XCNP=XCNP+1,^XMB(3.9,XMZ,2,XCNP,0)=XPDNM,XCNP=XCNP+1
 F  S GR=$Q(@GR) Q:GR=""!($E(GR,1,GL)'=GCK)  S ^XMB(3.9,XMZ,2,XCNP,0)=$P(GR,GCK,2),XCNP=XCNP+1,^XMB(3.9,XMZ,2,XCNP,0)=@GR,XCNP=XCNP+1
 S ^XMB(3.9,XMZ,2,XCNP,0)="$END KID "_XPDNM
 Q
