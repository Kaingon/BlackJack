clear;
clc;
%% Deck Initialization

%Vector 1: Spades
%Vector 2: Hearts
%Vector 3: Diamonds
%Vector 4: Clubs
Spades=[1:13];
SpadeState=ones(1,length(Spades));
Hearts=[1:13];
HeartState=ones(1,length(Hearts));
Diamonds=[1:13];
DiamondState=ones(1,length(Diamonds));
Clubs=[1:13];
ClubState=ones(1,length(Clubs));

%% Create Deck Array
Deck(1,:,1)=Spades;
Deck(2,:,1)=Hearts;
Deck(3,:,1)=Diamonds;
Deck(4,:,1)=Clubs;
Deck(1,:,2)=SpadeState;
Deck(2,:,2)=HeartState;
Deck(3,:,2)=DiamondState;
Deck(4,:,2)=ClubState;

%% Specify Number of AI Players
valid = 0;
MaxPlayers=13;
while valid == 0;
NumAIPlayers=input('Enter Number of Additional AI Players (Max is 11):  ');

%Validate Input
if NumAIPlayers > MaxPlayers-2
fprintf('\n Too many players! \n \n');

elseif NumAIPlayers < 0
fprintf('\n Cannot have negative player count! \n \n');

elseif NumAIPlayers-fix(NumAIPlayers) ~= 0;
fprintf('\n No partial players! \n \n');

else
    valid=1;
end
end

%% Specify Number of Human Players
valid = 0;
MaxHumanPlayers=MaxPlayers-NumAIPlayers-1;
while valid == 0;
    prompt = sprintf('Enter Number of Human Players (Max is %g, Min is 1):  ',MaxHumanPlayers);
NumHumanPlayers=input(prompt);

%Validate Input
if NumHumanPlayers > MaxHumanPlayers
fprintf('\n Too many players! \n \n');

elseif NumHumanPlayers < 1
fprintf('\n Not enough players! \n \n');

elseif NumHumanPlayers-fix(NumHumanPlayers) ~= 0;
fprintf('\n No partial players! \n \n');

else
    valid=1;
end
end

%% Specify Starting Cash
valid = 0;
CashMAX=100000;
while valid == 0;
    prompt = sprintf('Enter starting cash (Max is %g, Min is 1000):  ',CashMAX);
NumCash=input(prompt);

%Validate Input
if NumCash > CashMAX
fprintf('\n Too much cash, highroller! \n \n');

elseif NumCash < 1000
fprintf('\n Not enough cash, hobo! \n \n');

elseif NumCash-fix(NumCash) ~= 0;
fprintf('\n Only whole dollars here! \n \n');

else
    valid=1;
end
end

%%
NumTotalPlayers=NumAIPlayers+NumHumanPlayers+1;
%%  Player State Array
%Dimension 1: Contains Empty/AI/Human/Dealer Status (0, 1, 2, 3) and Cash
%Notes: Column # is Player ID #
%Money is stored in row 2
%The dealer is treated as the house, having "infinite" money, so his slot
%is initialized, but unused.
%Column 1 is ALWAYS the dealer, and the AI go before Players
%Dimension 2: Contains Hand Status (Row # is Card ID #, Value is Quantity)
%Card IDs 1-13: A,1,2,3,4,5,6,7,8,9,J,Q,K
Players=zeros(13,MaxPlayers,2); %Initialize the array

%Initialize Dealer
Players(1,1,1)=3;

%Initialize AI Status(es)
for InitCounter = 2:NumAIPlayers+1
Players(1,InitCounter,1)=1;
Players(2,InitCounter,1)=NumCash;
end

%Initialize Player Status(es)
for InitCounter = NumAIPlayers+2:NumTotalPlayers
Players(1,InitCounter,1)=2;
Players(2,InitCounter,1)=NumCash;
end

%% Welcome Message
clc
fprintf('\n Welcome to MATJack! \n');
fprintf('\n ---------------------------------------------- \n');
fprintf('\n Commands: \n');
fprintf('\n Commands    : Displays the command list');
fprintf('\n Cash        : Displays how much money you have');
fprintf('\n QuitProgram : End the Program');
fprintf('\n HitMe       : Draws a card');
fprintf('\n StayHand    : Stays your hand');
fprintf('\n DoubleDown  : Doubles down, when permitted \n');
fprintf('\n ---------------------------------------------- \n');
%fprintf('\n Split    : Splits your hand, currently unimplemented');

