## Copyright (C) 2018 Karlos, Syuzanna, David
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## --About Function--
## The function takes two mandatory arguments that specify two datasets with
## same number of points and compares their compatibility with point pattern
## matching algorithm. The resulting error is returned.

## @deftypefn {} {@var{error} = number} ppm (@var{Q}, @var{P}, @var{verbose})
##    Input Arguments:
##      Q -> matrix with 2 rows that specify x and y coordinates of each point.
##        Number of columns depends on number of datapoints that describe the 
##        object. Specifies the first matrix to be compared.
##      P -> matrix with 2 rows that specify x and y coordinates of each point.
##        Number of columns depends on number of datapoints that describe the 
##        object. Specifies the second matrix to be compared.
##      verbose (optional) -> if true prints error
##        default: false
##

## Created: 2018-05-21

function [error] = ppm (Q, P, verbose=false)

  R = [];
  R_T = [];
  Sum_R = zeros(2,2);
  Sum_R_T = zeros(2,2);
  Sum_RRT = zeros(2,2);
  I_2 = eye(2);
  b = zeros(4,1);

  for i = 1:length(P)
    R = horzcat(R, [P(1,i) -P(2,i); P(2,i) P(1,i)]);
    R_T = horzcat(R_T, transpose([P(1,i) -P(2,i); P(2,i) P(1,i)]));
  end

  for i= 1:length(P)
    R_i = [R(1, 2*i-1) R(1, 2*i); R(2, 2*i-1) R(2, 2*i)];
    R_T_i = [R_T(1, 2*i-1) R_T(1, 2*i); R_T(2, 2*i-1) R_T(2, 2*i)];
    
    Sum_RRT = Sum_RRT + R_T_i*R_i;
    
    Sum_R(1,1) = Sum_R(1,1) + R_i(1, 1);
    Sum_R(1,2) = Sum_R(1,2) + R_i(1, 2);
    Sum_R(2,1) = Sum_R(2,1) + R_i(2, 1);
    Sum_R(2,2) = Sum_R(2,2) + R_i(2, 2);
    
    Sum_R_T(1,1) = Sum_R_T(1,1) + R_T_i(1, 1);
    Sum_R_T(1,2) = Sum_R_T(1,2) + R_T_i(1, 2);
    Sum_R_T(2,1) = Sum_R_T(2,1) + R_T_i(2, 1);
    Sum_R_T(2,2) = Sum_R_T(2,2) + R_T_i(2, 2);
    
  %  temp = transpose(horzcat(R_i, I_2));
    b = b + transpose(horzcat(R_i, I_2))*Q(:, i);
  end


  I_2 = length(P)*I_2;

  H = vertcat(horzcat(Sum_RRT,Sum_R_T), horzcat(Sum_R, I_2));

  x_opt = inv(H)*b;

  P_est = [];
  for i = 1:length(P)
    rot = [x_opt(1) -1*x_opt(2); x_opt(2) x_opt(1)]*P(:, i);
    P_est = horzcat(P_est, rot+[x_opt(3);x_opt(4)]);
  end

  error = norm(P_est-Q,'fro');
  if verbose
    disp(error);
  endif
endfunction
