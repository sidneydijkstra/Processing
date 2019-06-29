public class Move{

  Piece movePiece;
  Piece[] destroyPieces;
  
  public Move(Piece movePiece, Piece[] destroyPieces){
    this.movePiece = movePiece;
    this.destroyPieces = destroyPieces;
  }
  
  //public static Move combine(Move _a, Move _b){
  //  _a.destroyPieces = (Piece[])concat(_b.destroyPieces, _a.destroyPieces);
  //  return _a;
  //}
  
}