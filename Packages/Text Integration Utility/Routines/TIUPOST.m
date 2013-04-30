TIUPOST ; SLC/JER - Post-init for TIU ;2/17/95  11:15
 ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997
MAIN ; Control branching
 D ^TIUIL        ;   Install List Templates
 D COMPILE       ;   Compile hidden menus
 D KILL^TIUDD8   ;   Force recompilation of SEARCH CATEGORIES
 D EN^TIULEXP    ;   Redirect ^LEX( ptr in PROBLEM LINK file
 S $P(^TIU(8925.1,0),U,3)=100  ; Reset file root to fill gaps
 Q
COMPILE ; Compile Hidden Menus
 N DIC,XQORM,X,Y
 D BMES^XPDUTL("*** COMPILING HIDDEN PROTOCOL MENUS ***")
 S DIC="^ORD(101,",DIC(0)="X",X="TIU HIDDEN ACTIONS" D ^DIC
 I +Y D
 . D MES^XPDUTL($P(Y,U,2)_".")
 . S XQORM=+Y_";ORD(101,",XQORM(0)="" D ^XQORM
 S DIC="^ORD(101,",DIC(0)="X",X="TIU HIDDEN ACTIONS ADVANCED" D ^DIC
 I +Y D
 . D MES^XPDUTL($P(Y,U,2)_".")
 . S XQORM=+Y_";ORD(101,",XQORM(0)="" D ^XQORM
 S DIC="^ORD(101,",DIC(0)="X",X="TIU HIDDEN ACTIONS OE/RR" D ^DIC
 I +Y D
 . D MES^XPDUTL($P(Y,U,2)_".")
 . S XQORM=+Y_";ORD(101,",XQORM(0)="" D ^XQORM
 S DIC="^ORD(101,",DIC(0)="X",X="TIU HIDDEN ACTIONS BROWSE" D ^DIC
 I +Y D
 . D MES^XPDUTL($P(Y,U,2)_".")
 . S XQORM=+Y_";ORD(101,",XQORM(0)="" D ^XQORM
 Q
