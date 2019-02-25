****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH F_y  $    3;
LENGTH I_y  $    3;
LENGTH U_y  $    3;
LENGTH _WARN_  $    4;
 
******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_yno = 'Predicted: y=no' ;
label P_yyes = 'Predicted: y=yes' ;
label Q_yno = 'Unadjusted P: y=no' ;
label Q_yyes = 'Unadjusted P: y=yes' ;
label R_yno = 'Residual: y=no' ;
label R_yyes = 'Residual: y=yes' ;
label F_y = 'From: y' ;
label I_y = 'Into: y' ;
label U_y = 'Unnormalized Into: y' ;
label _WARN_ = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_3 $      3; DROP _ARBFMT_3;
_ARBFMT_3 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_1 $      1; DROP _ARBFMT_1;
_ARBFMT_1 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_7 $      7; DROP _ARBFMT_7;
_ARBFMT_7 = ' '; /* Initialize to avoid warning. */
 
 
_ARBFMT_3 = PUT( y , $3.);
 %DMNORMCP( _ARBFMT_3, F_y );
 
******             ASSIGN OBSERVATION TO NODE             ******;
_ARBFMT_1 = PUT( ConsumerGroup , $1.);
 %DMNORMIP( _ARBFMT_1);
IF _ARBFMT_1 IN ('B' ) THEN DO;
  IF  NOT MISSING(balance ) AND
                896373.5 <= balance  THEN DO;
    IF  NOT MISSING(balance ) AND
                 1146637.5 <= balance  THEN DO;
      _NODE_  =                   11;
      _LEAF_  =                    9;
      P_yno  =     0.05155746509129;
      P_yyes  =      0.9484425349087;
      Q_yno  =     0.05155746509129;
      Q_yyes  =      0.9484425349087;
      I_y  = 'YES' ;
      U_y  = 'yes' ;
      END;
    ELSE DO;
      _NODE_  =                   10;
      _LEAF_  =                    8;
      P_yno  =     0.23989361702127;
      P_yyes  =     0.76010638297872;
      Q_yno  =     0.23989361702127;
      Q_yyes  =     0.76010638297872;
      I_y  = 'YES' ;
      U_y  = 'yes' ;
      END;
    END;
  ELSE DO;
    _ARBFMT_7 = PUT( last_campaign_outcome , $7.);
     %DMNORMIP( _ARBFMT_7);
    IF _ARBFMT_7 IN ('SUCCESS' ) THEN DO;
      _NODE_  =                    8;
      _LEAF_  =                    1;
      P_yno  =     0.12443095599393;
      P_yyes  =     0.87556904400607;
      Q_yno  =     0.12443095599393;
      Q_yyes  =     0.87556904400607;
      I_y  = 'YES' ;
      U_y  = 'yes' ;
      END;
    ELSE DO;
      _ARBFMT_3 = PUT( val_email , $3.);
       %DMNORMIP( _ARBFMT_3);
      IF _ARBFMT_3 IN ('YES' ) THEN DO;
        IF  NOT MISSING(balance ) AND
          balance  <              87919.5 THEN DO;
          _NODE_  =                   36;
          _LEAF_  =                    2;
          P_yno  =     0.11666666666666;
          P_yyes  =     0.88333333333333;
          Q_yno  =     0.11666666666666;
          Q_yyes  =     0.88333333333333;
          I_y  = 'YES' ;
          U_y  = 'yes' ;
          END;
        ELSE DO;
          _ARBFMT_3 = PUT( month , $3.);
           %DMNORMIP( _ARBFMT_3);
          IF _ARBFMT_3 IN ('OCT' ,'NOV' ,'DEC' ,'FEB' ,'MAR' ,'APR' ,'SEP' )
           THEN DO;
            _NODE_  =                   73;
            _LEAF_  =                    4;
            P_yno  =     0.25749559082892;
            P_yyes  =     0.74250440917107;
            Q_yno  =     0.25749559082892;
            Q_yyes  =     0.74250440917107;
            I_y  = 'YES' ;
            U_y  = 'yes' ;
            END;
          ELSE DO;
            _NODE_  =                   72;
            _LEAF_  =                    3;
            P_yno  =     0.39740259740259;
            P_yyes  =      0.6025974025974;
            Q_yno  =     0.39740259740259;
            Q_yyes  =      0.6025974025974;
            I_y  = 'YES' ;
            U_y  = 'yes' ;
            END;
          END;
        END;
      ELSE DO;
        IF  NOT MISSING(balance ) AND
          balance  <              85386.5 THEN DO;
          _NODE_  =                   38;
          _LEAF_  =                    5;
          P_yno  =      0.3016453382084;
          P_yyes  =     0.69835466179159;
          Q_yno  =      0.3016453382084;
          Q_yyes  =     0.69835466179159;
          I_y  = 'YES' ;
          U_y  = 'yes' ;
          END;
        ELSE DO;
          _ARBFMT_3 = PUT( month , $3.);
           %DMNORMIP( _ARBFMT_3);
          IF _ARBFMT_3 IN ('OCT' ,'DEC' ,'MAR' ,'SEP' ) THEN DO;
            _NODE_  =                   77;
            _LEAF_  =                    7;
            P_yno  =     0.28857142857142;
            P_yyes  =     0.71142857142857;
            Q_yno  =     0.28857142857142;
            Q_yyes  =     0.71142857142857;
            I_y  = 'YES' ;
            U_y  = 'yes' ;
            END;
          ELSE DO;
            _NODE_  =                   76;
            _LEAF_  =                    6;
            P_yno  =     0.56392757660167;
            P_yyes  =     0.43607242339832;
            Q_yno  =     0.56392757660167;
            Q_yyes  =     0.43607242339832;
            I_y  = 'NO' ;
            U_y  = 'no' ;
            END;
          END;
        END;
      END;
    END;
  END;
ELSE DO;
  _ARBFMT_1 = PUT( ConsumerGroup , $1.);
   %DMNORMIP( _ARBFMT_1);
  IF _ARBFMT_1 IN ('C' ,'D' ) THEN DO;
    IF  NOT MISSING(balance ) AND
                    883671 <= balance  THEN DO;
      IF  NOT MISSING(balance ) AND
                     1167668 <= balance  THEN DO;
        _NODE_  =                   27;
        _LEAF_  =                   15;
        P_yno  =      0.1554054054054;
        P_yyes  =     0.84459459459459;
        Q_yno  =      0.1554054054054;
        Q_yyes  =     0.84459459459459;
        I_y  = 'YES' ;
        U_y  = 'yes' ;
        END;
      ELSE DO;
        _NODE_  =                   26;
        _LEAF_  =                   14;
        P_yno  =     0.53965183752417;
        P_yyes  =     0.46034816247582;
        Q_yno  =     0.53965183752417;
        Q_yyes  =     0.46034816247582;
        I_y  = 'NO' ;
        U_y  = 'no' ;
        END;
      END;
    ELSE DO;
      _ARBFMT_7 = PUT( last_campaign_outcome , $7.);
       %DMNORMIP( _ARBFMT_7);
      IF _ARBFMT_7 IN ('SUCCESS' ) THEN DO;
        _NODE_  =                   24;
        _LEAF_  =                   10;
        P_yno  =     0.34313725490196;
        P_yyes  =     0.65686274509803;
        Q_yno  =     0.34313725490196;
        Q_yyes  =     0.65686274509803;
        I_y  = 'YES' ;
        U_y  = 'yes' ;
        END;
      ELSE DO;
        _ARBFMT_3 = PUT( val_email , $3.);
         %DMNORMIP( _ARBFMT_3);
        IF _ARBFMT_3 IN ('YES' ) THEN DO;
          _NODE_  =                   50;
          _LEAF_  =                   11;
          P_yno  =     0.67977528089887;
          P_yyes  =     0.32022471910112;
          Q_yno  =     0.67977528089887;
          Q_yyes  =     0.32022471910112;
          I_y  = 'NO' ;
          U_y  = 'no' ;
          END;
        ELSE DO;
          _ARBFMT_3 = PUT( month , $3.);
           %DMNORMIP( _ARBFMT_3);
          IF _ARBFMT_3 IN ('OCT' ,'MAR' ) THEN DO;
            _NODE_  =                   95;
            _LEAF_  =                   13;
            P_yno  =     0.44155844155844;
            P_yyes  =     0.55844155844155;
            Q_yno  =     0.44155844155844;
            Q_yyes  =     0.55844155844155;
            I_y  = 'YES' ;
            U_y  = 'yes' ;
            END;
          ELSE DO;
            _NODE_  =                   94;
            _LEAF_  =                   12;
            P_yno  =     0.83568846533026;
            P_yyes  =     0.16431153466973;
            Q_yno  =     0.83568846533026;
            Q_yyes  =     0.16431153466973;
            I_y  = 'NO' ;
            U_y  = 'no' ;
            END;
          END;
        END;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(balance ) AND
                  993550.5 <= balance  THEN DO;
      IF  NOT MISSING(balance ) AND
                   1246600.5 <= balance  THEN DO;
        _NODE_  =                   31;
        _LEAF_  =                   22;
        P_yno  =     0.30337078651685;
        P_yyes  =     0.69662921348314;
        Q_yno  =     0.30337078651685;
        Q_yyes  =     0.69662921348314;
        I_y  = 'YES' ;
        U_y  = 'yes' ;
        END;
      ELSE DO;
        _ARBFMT_7 = PUT( last_campaign_outcome , $7.);
         %DMNORMIP( _ARBFMT_7);
        IF _ARBFMT_7 IN ('SUCCESS' ) THEN DO;
          _NODE_  =                   60;
          _LEAF_  =                   20;
          P_yno  =      0.3095238095238;
          P_yyes  =     0.69047619047619;
          Q_yno  =      0.3095238095238;
          Q_yyes  =     0.69047619047619;
          I_y  = 'YES' ;
          U_y  = 'yes' ;
          END;
        ELSE DO;
          _NODE_  =                   61;
          _LEAF_  =                   21;
          P_yno  =     0.77314814814814;
          P_yyes  =     0.22685185185185;
          Q_yno  =     0.77314814814814;
          Q_yyes  =     0.22685185185185;
          I_y  = 'NO' ;
          U_y  = 'no' ;
          END;
        END;
      END;
    ELSE DO;
      _ARBFMT_7 = PUT( last_campaign_outcome , $7.);
       %DMNORMIP( _ARBFMT_7);
      IF _ARBFMT_7 IN ('SUCCESS' ) THEN DO;
        _NODE_  =                   28;
        _LEAF_  =                   16;
        P_yno  =     0.71364653243847;
        P_yyes  =     0.28635346756152;
        Q_yno  =     0.71364653243847;
        Q_yyes  =     0.28635346756152;
        I_y  = 'NO' ;
        U_y  = 'no' ;
        END;
      ELSE DO;
        _ARBFMT_3 = PUT( val_email , $3.);
         %DMNORMIP( _ARBFMT_3);
        IF _ARBFMT_3 IN ('YES' ) THEN DO;
          _NODE_  =                   58;
          _LEAF_  =                   17;
          P_yno  =     0.90285161913968;
          P_yyes  =     0.09714838086031;
          Q_yno  =     0.90285161913968;
          Q_yyes  =     0.09714838086031;
          I_y  = 'NO' ;
          U_y  = 'no' ;
          END;
        ELSE DO;
          _ARBFMT_3 = PUT( month , $3.);
           %DMNORMIP( _ARBFMT_3);
          IF _ARBFMT_3 IN ('OCT' ,'DEC' ,'MAR' ,'SEP' ) THEN DO;
            _NODE_  =                  110;
            _LEAF_  =                   18;
            P_yno  =     0.83836589698046;
            P_yyes  =     0.16163410301953;
            Q_yno  =     0.83836589698046;
            Q_yyes  =     0.16163410301953;
            I_y  = 'NO' ;
            U_y  = 'no' ;
            END;
          ELSE DO;
            _NODE_  =                  111;
            _LEAF_  =                   19;
            P_yno  =     0.95696015740285;
            P_yyes  =     0.04303984259714;
            Q_yno  =     0.95696015740285;
            Q_yyes  =     0.04303984259714;
            I_y  = 'NO' ;
            U_y  = 'no' ;
            END;
          END;
        END;
      END;
    END;
  END;
 
*****  RESIDUALS R_ *************;
IF  F_y  NE 'NO'
AND F_y  NE 'YES'  THEN DO;
        R_yno  = .;
        R_yyes  = .;
 END;
 ELSE DO;
       R_yno  =  -P_yno ;
       R_yyes  =  -P_yyes ;
       SELECT( F_y  );
          WHEN( 'NO'  ) R_yno  = R_yno  +1;
          WHEN( 'YES'  ) R_yyes  = R_yyes  +1;
       END;
 END;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
