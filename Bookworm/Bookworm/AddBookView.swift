//
//  AddBookView.swift
//  Bookworm
//
//  Created by Nana Bonsu on 4/21/23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss //needed to
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 0
    @State private var genre = ""
    @State private var review = ""
    @State private var showingErrorAlert = false
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery","Poetry", "Romance", "Thriller"]
    
    //
    var body: some View {
        NavigationView {
            Form {
                //dividing the form into sections
                Section {
                    TextField("Name of Book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        //now make array of genres
                        
                        ForEach(genres,id: \.self) {
                            Text($0)
                        }
                    }
                }
//
//                Section {
//                    TextEditor(text: $review) //this allows you to enter text longer for the review
//
//                    Picker("Rating",selection: $rating) {
//                        ForEach(0..<6) {
//                            Text(String($0))
//                        }
//                    }
//                }
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
            
                header: {
                    Text("write a review")
                }
                
                Section {
                    Button("Save")  {
                        //functions for adding a book, or actually gra bing data from coredata
                        
                        if(title.isEmpty || author.isEmpty) {
                            showingErrorAlert = true
                        } else {
                            let newBook = Book(context:moc)
                            
                            newBook.id = UUID()
                            newBook.title = title
                            newBook.author = author
                            newBook.rating = Int16(exactly: rating)! //casting to Int16
                            newBook.review = review
                            newBook.genre = genre
                            
                            try? moc.save()
                            dismiss()
                        }
                    }
                }
            }
            .navigationTitle("Add a Book")
            .alert("Something is Missing",isPresented: $showingErrorAlert) {
                Button("OK") {}
            } message: {
                Text("Plese check if you have included the author's name and book")
            }
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
