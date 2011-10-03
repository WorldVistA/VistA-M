PXAIUPRV ;ISL/JVS - VALIDATE THE PAROVDER NODES ;6/6/96  07:42
 ;;1.0;PCE PATIENT CARE ENCOUNTER;;Aug 12, 1996
 Q
 ;
01(IEN) ;
 I '$D(^VA(200,+IEN,0)) S PXCA("ERROR","PROVIDER",IEN,0,0)="Provider not in File 200^"_IEN,PXAIVAL=1
 ;E  I '$D(^VA(200,"AK.PROVIDER",$P($G(^VA(200,+IEN,0)),"^"))) S PXCA("ERROR","PROVIDER",IEN,0,0)="Provider does not have the AK.PROVIDER key^"_IEN,PXAIVAL=2
 Q
 ;
04(IEN,PRIMARY) ;
 I '(PRIMARY="P"!(PRIMARY="S")) S PXCA("ERROR","PROVIDER",IEN,0,1)="Provider indicator code must be P|S^"_PRIMARY,PXAIVAL=1
 ;If there is more than one primary the change additional ones to secondary.
 I PRIMARY="P" D
 . I 'PXCAPPRV S PXCAPPRV=IEN
 . E  I PXCAPPRV'=IEN D
 .. S PXCA("WARNING","PROVIDER",IEN,0,1)="There is already a Primary Provider this one is changed to Secondary^"_PRIMARY
 .. S $P(PXCAPRV,"^",1)="S"
 Q
 ;
05(ATTEND) ;
 I '(ATTEND=1!(ATTEND=0)!(ATTEND="")) S PXCA("ERROR","PROVIDER",IEN,0,2)="Attending flag bad^"_ATTEND,PXAIVAL=1
 Q
 ;
