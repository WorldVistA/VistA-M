SCDDI1 ;ALB/SCK/JLU - DD Calls used by Incomplete Encounter Management ; 6/6/97
 ;;5.3;Scheduling;**66**;AUG 13, 1993
 Q
SETAEDT(DA,X) ;
 Q:'$G(DA)!('$G(X))
 N SDT,SDTD,SDX
 S (SDT,SDTD)=""
 S SDT=$P($G(^SD(409.73,X,0)),"^",2)
 I 'SDT S SDTD=$P($G(^SD(409.73,X,0)),"^",3)
 Q:'SDT&('SDTD)
 I SDT S SDT=$P($G(^SCE(SDT,0)),"^")
 I SDTD S SDT=$P($G(^SD(409.74,SDTD,0)),"^")
 S:SDT ^SD(409.75,"AEDT",SDT,X,DA)=""
 Q
 ;
KILAEDT(DA,X) ;
 Q:'$G(DA)!('$G(X))
 N SDT,SDTD,SDX
 S (SDT,SDTD)=""
 S SDT=$P($G(^SD(409.73,X,0)),"^",2)
 I 'SDT S SDTD=$P($G(^SD(409.73,X,0)),"^",3)
 Q:'SDT&('SDTD)
 I SDT S SDT=$P($G(^SCE(SDT,0)),"^")
 I SDTD S SDT=$P($G(^SD(409.74,SDTD,0)),"^")
 K:SDT ^SD(409.75,"AEDT",SDT,X,DA)
 Q
 ;
SETAECL(DA,X) ;
 Q:'$G(DA)!('$G(X))
 N SDCL,SDX,SDT,SDTD
 S (SDCL,SDT,SDTD)=""
 S SDT=$P($G(^SD(409.73,X,0)),"^",2)
 I 'SDT S SDTD=$P($G(^SD(409.73,X,0)),"^",3)
 Q:'SDT&('SDTD)
 I SDT S SDCL=$P($G(^SCE(SDT,0)),"^",4)
 I SDTD S SDCL=$P($G(^SD(409.74,SDTD,1)),"^",4)
 Q:'SDCL
 S:SDCL ^SD(409.75,"AECL",SDCL,DA)=""
 Q
 ;
KILAECL(DA,X) ;
 Q:'$G(DA)!('$G(X))
 N SDT,SDTD,SDCL
 S (SDT,SDTD,SDCL)=""
 S SDT=$P($G(^SD(409.73,X,0)),"^",2)
 I 'SDT S SDTD=$P($G(^SD(409.73,X,0)),"^",3)
 Q:'SDT&('SDTD)
 I SDT S SDCL=$P($G(^SCE(SDT,0)),"^",4)
 I SDTD S SDCL=$P($G(^SD(409.74,SDTD,1)),"^",4)
 Q:'SDCL
 K ^SD(409.75,"AECL",SDCL,DA)
 Q
 ;
SETACOD1(DA,X) ;
 Q:'$G(DA)!('$G(X))
 N DFN,COD
 S COD=$P(^SD(409.75,DA,0),U,2)
 I COD']"" Q
 S COD=$P($G(^SD(409.76,COD,0)),U,1)
 I COD']"" Q
 S DFN=$P(^SD(409.75,DA,0),U,1)
 I 'DFN Q
 D PATDFN^SCDXUTL2(DFN)
 I 'DFN Q
 S ^SD(409.75,"ACOD",DFN,COD,DA)=""
 Q
 ;
KILACOD1(DA,X) ;
 Q:'$G(DA)!('$G(X))
 N DFN,COD
 S COD=$P(^SD(409.75,DA,0),U,2)
 I COD']"" Q
 S COD=$P($G(^SD(409.76,COD,0)),U,1)
 I COD']"" Q
 S DFN=$P(^SD(409.75,DA,0),U,1)
 I 'DFN Q
 D PATDFN^SCDXUTL2(DFN)
 I 'DFN Q
 K ^SD(409.75,"ACOD",DFN,COD,DA)
 Q
 ;
SETACOD2(DA,X) ;
 Q:'$G(DA)!('$G(X))
 N DFN,COD
 S DFN=$P(^SD(409.75,DA,0),U,1)
 I 'DFN Q
 D PATDFN^SCDXUTL2(DFN)
 I 'DFN Q
 S COD=$P($G(^SD(409.76,$E(X,1,30),0)),U,1)
 I COD']"" Q
 S ^SD(409.75,"ACOD",DFN,COD,DA)=""
 Q
 ;
KILACOD2(DA,X) ;
 Q:'$G(DA)!('$G(X))
 N DFN,COD
 S DFN=$P(^SD(409.75,DA,0),U,1)
 I 'DFN Q
 D PATDFN^SCDXUTL2(DFN)
 I 'DFN Q
 S COD=$P($G(^SD(409.76,$E(X,1,30),0)),U,1)
 I COD']"" Q
 K ^SD(409.75,"ACOD",DFN,COD,DA)
 Q
