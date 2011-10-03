XU8P483 ;FO-OAK/JLI-Post-init routine for patch XU*8*483 ;1/30/08  14:20
 ;;8.0;KERNEL;**483**;Jul 10, 1995;Build 15
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
EN ;
 N XUFDA
 I +$G(XPDQUES("POS1"))>0 S XUFDA(8989.3,"1,",321.01)=+XPDQUES("POS1")
 I +$G(XPDQUES("POS2"))>0 S XUFDA(8989.3,"1,",321.02)=+XPDQUES("POS2")
 I $D(XUFDA) D UPDATE^DIE("","XUFDA")
 D ^XQ55SPEC
 Q
