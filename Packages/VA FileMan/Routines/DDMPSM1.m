DDMPSM1 ;SFISC/DPC-IMPORT SCREENMAN CALLS (CONT) ;9/20/96  11:28
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
HOSTHELP ;Called from HELP on the Host File prompt.
 N DDMPPATH
 S DDMPPATH=$$GET^DDSVALF("PTH",1,1)
 K ^TMP($J,"DDMPHOST")
 D GETHOSTS(DDMPPATH,$NA(^TMP($J,"DDMPHF")))
 S ^TMP($J,"DDMPHOST",1)="Enter the name of the host file that contains the data to be imported."
 I $D(^TMP($J,"DDMPHF")) D
 . S ^TMP($J,"DDMPHOST",2)=""
 . S ^TMP($J,"DDMPHOST",3)="These are the files in the "_DDMPPATH_" directory:"
 . N DDMPHFNM,I S DDMPHFNM=""
 . F I=4:1 S DDMPHFNM=$O(^TMP($J,"DDMPHF",DDMPHFNM)) Q:DDMPHFNM=""  S ^TMP($J,"DDMPHOST",I)=DDMPHFNM S:I#2 ^(I,"F")="?40"
 . D EN^DDIOL("","^TMP($J,""DDMPHOST"")")
 K ^TMP($J,"DDMPHF"),^TMP($J,"DDMPHOST")
 Q
 ;
GETHOSTS(DDMPPATH,DDMPHFAR) ;
 ;Obtains list of all host files in a specified directory.
 ;Input:
 ;DDMPPATH - Directory name w/ full path.
 ;DDMPHFAR - Target array for output from $$LIST^%ZISH call.
 N DDMPHF
 I DDMPPATH="" Q
 S DDMPHF("*.*")=""
 K @DDMPHFAR
 I $$LIST^%ZISH(DDMPPATH,"DDMPHF",DDMPHFAR)
 Q
PAGE2 ;
 ;Call from page 2 pre-action.
 I $D(DDMPFRP4) K DDMPFRP4 Q
 I $G(DDMPF)="" D  Q
 . S DDSBR="F_SEL^1^1"
 . D HLP^DDSUTL($C(7)_"You must choose a file before you can go to the Field Selection page.")
 S DDMPCF=$G(DDMPCF,DDMPF)
 D UNED^DDSUTL("LEN",1,2,$S($G(DDMPSMFF("FIXED"))="YES":0,1:1))
 I $G(DDMPSMFF("FIXED"))="YES",DDMPFDCT,'$D(DDMPFDSL("LN")) D
 . N DDMPHLP
 . S DDSBR="FLD_DEL"
 . S DDMPHLP(1)=$C(7)
 . S DDMPHLP(2)="You have specified a fixed length format for imported data."
 . S DDMPHLP(3)="However, you have not entered field lengths for fields you have chosen."
 . S DDMPHLP(4)="So, you must either delete all the fields entered so far"
 . S DDMPHLP(5)="or change the format to one that is not fixed length."
 . D HLP^DDSUTL(.DDMPHLP)
 Q
 ;
LENCHK ;
 ;Called from the post action on change field of the Length: prompt pop-up page.
 I X="L" D
 . S DDSBR="LEN^1^2"
 E  D
 . D DELFLD^DDMPSM
 . S DDSBR="FLD^1^2"
 . D PUT^DDSVALF("FLD",1,2,"")
 D PUT^DDSVALF(2,1,4,"")
 Q
