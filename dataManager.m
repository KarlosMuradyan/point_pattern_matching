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

## -*- About Function -*- 
## This function gets P cell of matrix of datapoints and takes input from user
## in order to compare it with items in P with ppm( Point-Pattern Matching)
## algorithm.

## @deftypefn {} {@var{res} = array} dataManager (@var{P}, @var{dim}, @var{prec}, @var{vbs})
##    Input Arguments:
##      P -> cell of matrix of datapoints to be compared with.
##          The input data will be compared with each element of P.
##      dim -> Specifies the number of datapoints for each input and for P's
##          datapoints
##          default: 15
##      prec(optional) -> rounds the datapoints' coordinates. E.g. if prec==10, the 
##          algorithm rounds till nearset tenths
##          default: 100
##      vbs(optional) -> displays errors of each dataset in the same order as it
##          was given with stem plot.
##          default: false
##
##    Returns:
##      res -> array containing errors
## @seealso{}
## @end deftypefn

## Created: 2018-05-21

function [res] = dataManager (P, dim=15, prec=100, vbs=false)
  
  %Get user input
  Q = [];
  h2 = text(0, 0.95, strcat('Remaining Points: ', int2str(dim)));
  for pts = dim:-1:1
    [X,Y] = ginput(1);
    h1 = text(X,Y,'*', ...
                    'HorizontalAlignment','center', ...
                    'Color', [1 0 0], ...
                    'FontSize',8);
    delete(h2);
    h2 = text(0, 0.95, strcat('Remaining Points: ', int2str(pts-1)));
    hold on;
    Q = horzcat(Q, vertcat(X, Y));
  endfor
  
  %Calling point pattern matchin algorithm for each dataset and input
  res = [];
  for k = 1:1:length(P)
    res(end+1) = ppm(round(Q*prec)/prec, round(P{k}*prec)/prec, verbose=vbs);
  endfor
  
  %If verbose is true, creates stem plot, displaying all errors
  if vbs
    figure
    stem(res)
    hold on;
  endif
  
endfunction
