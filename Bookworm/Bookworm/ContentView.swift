//
//  ContentView.swift
//  Bookworm
//
//  Created by Nana Bonsu on 4/19/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    //
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),SortDescriptor(\.author)]) var books:FetchedResults<Book> //sortDescriptord helps you to know how to sort
    
    @State private var showingAddScreen = false //boolean to determine whether next screen is shown or no
    
    var body: some View {
        NavigationView {
            //list to get all the books in database, or display it really
            List {
                ForEach(books) { book in
                    NavigationLink {
                        BookDetailView(book: book)
                    } label: {
                        //
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                                
                            
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                    .foregroundColor( book.rating == 1 ? Color.red : Color.black)
                                
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)  //twoo here so
                                    .foregroundColor(book.rating == 1 ? Color.red : Color.black)
                            }
                        }
                    }
                
                    
                }
                .onDelete(perform: deleteBooks)
            }
                .navigationTitle("Bookworm")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                       EditButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddScreen.toggle()
                        } label: {
                            Label("Add a book",systemImage: "plus")
                        }
                    }
                } .sheet(isPresented: $showingAddScreen) {
                    AddBookView()
                }
    }
    }
    
    //function to deleting books
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
