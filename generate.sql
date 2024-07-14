CREATE TABLE Account
(
  id SERIAL PRIMARY KEY,
  Username VARCHAR(50) NOT NULL,
  Password VARCHAR(100) NOT NULL,
  LastName VARCHAR(50),
  FirstName VARCHAR(50)
);

CREATE TABLE FriendGroup
(
  id SERIAL PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  TimeCreated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Bill
(
  id SERIAL PRIMARY KEY,
  idGroup INT NOT NULL,
  Description TEXT NOT NULL DEFAULT '',
  Resolved BOOLEAN NOT NULL DEFAULT FALSE,
  TimeResolved TIMESTAMP,
  FOREIGN KEY (idGroup) REFERENCES FriendGroup (id)
);

CREATE TABLE GroupInvitation
(
  idGroup INT NOT NULL,
  idAccount INT NOT NULL,
  Status VARCHAR(20) NOT NULL,
  TimeInvited TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  InvitationByidAccount INT NOT NULL,
  FOREIGN KEY (idGroup) REFERENCES FriendGroup (id),
  FOREIGN KEY (idAccount) REFERENCES Account (id),
  FOREIGN KEY (InvitationByidAccount) REFERENCES Account (id),
  PRIMARY KEY (idGroup, idAccount, TimeInvited, InvitationByidAccount)
);

CREATE TABLE Settlement
(
  id SERIAL PRIMARY KEY,
  idBill INT NOT NULL,
  idAccount INT NOT NULL,
  ReceiveridAccount INT NOT NULL,
  Amount INT NOT NULL,
  Accepted BOOLEAN NOT NULL DEFAULT FALSE,
  TimeAccepted TIMESTAMP,
  FOREIGN KEY (idBill) REFERENCES Bill (id),
  FOREIGN KEY (idAccount) REFERENCES Account (id),
  FOREIGN KEY (ReceiveridAccount) REFERENCES Account (id)
);

CREATE TABLE UserBelongsToGroup
(
  idAccount INT NOT NULL,
  idGroup INT NOT NULL,
  TimeAdded TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (idAccount) REFERENCES Account (id),
  FOREIGN KEY (idGroup) REFERENCES FriendGroup (id),
  PRIMARY KEY (idAccount, idGroup)
);

CREATE TABLE Payment
(
  id SERIAL PRIMARY KEY,
  idBill INT NOT NULL,
  idAccount INT NOT NULL,
  Amount INT NOT NULL,
  Description TEXT NOT NULL DEFAULT '',
  Date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (idBill) REFERENCES Bill (id),
  FOREIGN KEY (idAccount) REFERENCES Account (id)
);

CREATE TABLE Debtor
(
  idAccount INT NOT NULL,
  idPayment INT NOT NULL,
  AmountOwed INT NOT NULL,
  FOREIGN KEY (idAccount) REFERENCES Account (id),
  FOREIGN KEY (idPayment) REFERENCES Payment (id),
  PRIMARY KEY (idAccount, idPayment)
);
