//
//  BookDetailView.swift
//  Bookworm
//
//  Created by Nana Bonsu on 4/24/23.
//

import SwiftUI
import CoreData

struct BookDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var showingDeleteAlert = false
    
    let book: Book
    var body: some View {
        
       
        
        ScrollView {
            //Using a ZStack to place genre name on top of picture
            
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre?.uppercased() ?? "Fantasy")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(Color.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5,y: -5) //put it in bottom right corner
            }
            
            Text(book.author ?? "Unknown Author")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(book.review ?? "No Review")
                .padding()
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
            
        }
        .navigationTitle(book.title ?? "Unknown book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete this book?", isPresented: $showingDeleteAlert) {
            //now buttons that will be used to do this
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) {}
        } message: {
            //Text always usually goes here!
            Text("Are you sure?")
            
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this book?", systemImage: "trash")
            }
        }
    }
    
    
    func deleteBook() {
        moc.delete(book)
        
        //making it perminent canuse
        
        try? moc.save()
        dismiss()
    }
    
}


//struct BookDetailView_Previews: PreviewProvider {
//    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//
//       static var previews: some View {
//           let book = Book(context: moc)
//           book.title = "Test book"
//           book.author = "Test author"
//           book.genre = "Fantasy"
//           book.rating = 4
//           book.review = "This was a great book; I really enjoyed it."
//
//           return NavigationView {
//               BookDetailView(book: book)
//           }
//       }
//   }


