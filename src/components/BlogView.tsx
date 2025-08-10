'use client';

import { useState, useEffect } from 'react';

type Post = {
  _id?: string;
  title: string;
  content: string;
};

export default function BlogView({ post, onClose }: Readonly<{ 
  post: Post; 
  onClose: () => void; 
}>) {
  const [currentDate, setCurrentDate] = useState<string>('');

  useEffect(() => {
    // Set date on client side to avoid hydration issues
    setCurrentDate(new Date().toLocaleDateString('en-US', { 
      year: 'numeric', 
      month: 'long', 
      day: 'numeric' 
    }));
  }, []);

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 modal-backdrop flex items-center justify-center p-4 z-50" style={{ margin: 0, top: 0, left: 0, right: 0, bottom: 0 }}>
      <div className="bg-white rounded-lg shadow-2xl max-w-4xl w-full max-h-[90vh] overflow-hidden mx-auto my-auto transform transition-all duration-300 ease-out">
        {/* Header */}
        <div className="bg-gradient-to-r from-blue-600 to-purple-600 px-6 py-4 flex justify-between items-center">
          <h1 className="text-2xl font-bold text-white">Blog Preview</h1>
          <button 
            onClick={onClose}
            className="text-white hover:text-gray-200 text-3xl font-bold w-8 h-8 flex items-center justify-center rounded-full hover:bg-white hover:bg-opacity-20 transition-colors"
            aria-label="Close preview"
          >
            ×
          </button>
        </div>
        
        {/* Blog Content */}
        <div className="p-8 overflow-y-auto max-h-[calc(90vh-8rem)] bg-white">
          <article className="prose prose-lg max-w-none">
            <header className="mb-8 border-b border-gray-200 pb-6">
              <h1 className="text-4xl font-bold text-gray-900 mb-4 leading-tight">
                {post.title}
              </h1>
              <div className="flex items-center text-gray-600 text-sm">
                <span className="flex items-center bg-gray-100 px-3 py-1 rounded-full">
                  <svg className="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 20 20">
                    <path fillRule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clipRule="evenodd" />
                  </svg>
                  {currentDate || 'Loading...'}
                </span>
                <span className="mx-4">•</span>
                <span className="flex items-center bg-gray-100 px-3 py-1 rounded-full">
                  <svg className="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 20 20">
                    <path fillRule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-6-3a2 2 0 11-4 0 2 2 0 014 0zm-2 4a5 5 0 00-4.546 2.916A5.986 5.986 0 0010 16a5.986 5.986 0 004.546-2.084A5 5 0 0010 11z" clipRule="evenodd" />
                  </svg>
                  Blog Author
                </span>
                <span className="mx-4">•</span>
                <span className="flex items-center bg-gray-100 px-3 py-1 rounded-full">
                  <svg className="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 20 20">
                    <path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                  Published
                </span>
              </div>
            </header>
            
            <div className="text-gray-800 leading-relaxed whitespace-pre-wrap text-lg space-y-4">
              {post.content.split('\n').map((paragraph, index) => (
                <p key={index} className="mb-4">
                  {paragraph}
                </p>
              ))}
            </div>
            
            <footer className="mt-12 pt-8 border-t border-gray-200">
              <div className="flex items-center justify-between text-sm text-gray-500">
                <div className="flex items-center space-x-4">
                  <span>👍 Like this post?</span>
                  <span>💬 Share your thoughts</span>
                </div>
                <div className="flex items-center">
                  <span>📝 My Blog Site</span>
                </div>
              </div>
            </footer>
          </article>
        </div>
        
        {/* Footer */}
        <div className="bg-gray-50 px-6 py-4 flex justify-between items-center border-t">
          <div className="text-sm text-gray-600">
            This is how your post will appear to readers
          </div>
          <button 
            onClick={onClose}
            className="bg-gray-600 hover:bg-gray-700 text-white font-semibold py-2 px-6 rounded-lg transition-colors duration-200"
          >
            Close Preview
          </button>
        </div>
      </div>
    </div>
  );
}
