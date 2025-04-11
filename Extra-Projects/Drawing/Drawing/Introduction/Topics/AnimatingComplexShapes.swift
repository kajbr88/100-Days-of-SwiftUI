import SwiftUI

struct CheckerBoard: Shape {
    var rows: Int
    var columns: Int
    
    public var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(rows), Double(columns))/* since the 1st generic parameter ins swift is named "First" and "first" is a property of "AnimatablePair" same for 2nd generic parameter(Second and second as property), newValue.first and newValue.second in setter depend on this format here in getter i.e. 1st parameter is accessed in setter using .first, means it gets the value of "rows" as defined in getter here and 2nd parameter is accessed in setter using .second means it gets the value of "columns" as defined in getter here.*/
        }
        /*"AnimatablePair<Double, Double>" As its name suggests, this contains a pair of animatable values, and because both its values can be animated
         the AnimatablePair can itself be animated. We can read individual values from the pair using .first and .second.*/
        set {
            rows = Int(newValue.first)// newValue is a parameter and its type is same as animatableData property itself. hence "first" property of AnimatablePair can be accessed using dot operator.
            columns = Int(newValue.second)// same thing happens here.
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // figure out how big each row/column needs to be
        let rowSize = rect.height / CGFloat(rows)
        let columnSize = rect.width / CGFloat(columns)
        
        // loop over all rows and columns, making alternating squares colored
        for row in 0..<rows {
            for column in 0..<columns {
                // colored squares
                if (row + column).isMultiple(of: 2) {/*path.addRect(rect) adds a rectangle black("The "black" color comes
from SwiftUI's default behavior of filling a Path with the view's foreground color.) CheckerBoard shape leaving which arent multiple of two to be empty spaces*/
                    // this square should be colored; add a rectangle here
                    let startX = columnSize * CGFloat(column)
                    let startY = rowSize * CGFloat(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        
        return path
    }
}

struct AnimatingComplexShapes: View {
    @State private var rows = 4
    @State private var columns = 4
    
    var body: some View {
        CheckerBoard(rows: rows, columns: columns)
        // note: tap works on even squares only, the rest being empty space
            .onTapGesture {
                withAnimation(.linear(duration: 3)) {
                    self.rows = 8
                    self.columns = 16
                }
            }
            .navigationBarTitle("Animating complex shapes with AnimatablePair", displayMode: .inline)
    }
}

struct AnimatingComplexShapes_Previews: PreviewProvider {
    static var previews: some View {
        AnimatingComplexShapes()
    }
}
