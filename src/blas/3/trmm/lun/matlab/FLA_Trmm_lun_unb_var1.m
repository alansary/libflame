%
%
%   Copyright (C) 2014, The University of Texas at Austin
%
%   This file is part of libflame and is available under the 3-Clause
%   BSD license, which can be found in the LICENSE file at the top-level
%   directory, or at http://opensource.org/licenses/BSD-3-Clause
%
%

function [ B_out ] = FLA_Trmm_lun_unb_var1( A, B )

  [ ATL, ATR, ...
    ABL, ABR ] = FLA_Part_2x2( A, ...
                               0, 0, 'FLA_TL' );

  [ BT, ...
    BB ] = FLA_Part_2x1( B, ...
                         0, 'FLA_TOP' );

  while ( size( ATL, 1 ) < size( A, 1 ) )

    [ A00,  a01,     A02,  ...
      a10t, alpha11, a12t, ...
      A20,  a21,     A22 ] = FLA_Repart_2x2_to_3x3( ATL, ATR, ...
                                                    ABL, ABR, ...
                                                    1, 1, 'FLA_BR' );

    [ B0, ...
      b1t, ...
      B2 ] = FLA_Repart_2x1_to_3x1( BT, ...
                                    BB, ...
                                    1, 'FLA_BOTTOM' );

    %------------------------------------------------------------%

    b1t = b1t * alpha11;
    b1t = b1t + a12t * B2;

    %------------------------------------------------------------%

    [ ATL, ATR, ...
      ABL, ABR ] = FLA_Cont_with_3x3_to_2x2( A00,  a01,     A02,  ...
                                             a10t, alpha11, a12t, ...
                                             A20,  a21,     A22, ...
                                             'FLA_TL' );

    [ BT, ...
      BB ] = FLA_Cont_with_3x1_to_2x1( B0, ...
                                       b1t, ...
                                       B2, ...
                                       'FLA_TOP' );

  end

  B_out = [ BT
            BB ];

return


