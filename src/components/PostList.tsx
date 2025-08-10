
'use client';

import { useEffect, useState } from 'react';

type Post = {
  _id?: string;
  title: string;
  content: string;
};

export default function PostList({ onEdit }: Readonly<{ onEdit: (post: Post) => void }>) {
  const [posts, setPosts] = useState<Post[]>([]);
  const [loading, setLoading] = useState(true);

  const fetchPosts = async () => {
    try {
      const response = await fetch('/api/posts');
      const data = await response.json();
      setPosts(data);
    } catch (error) {
      console.error('Error fetching posts:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (id: string) => {
    if (!confirm('Are you sure you want to delete this post?')) return;
    
    try {
      const response = await fetch(`/api/posts/${id}`, { method: 'DELETE' });
      if (response.ok) {
        const result = await response.json();
        console.log('Delete result:', result);
        fetchPosts(); // Refresh the list
      } else {
        console.error('Failed to delete post:', response.statusText);
        alert('Failed to delete post. Please try again.');
      }
    } catch (error) {
      console.error('Error deleting post:', error);
      alert('Error deleting post. Please try again.');
    }
  };

  useEffect(() => {
    fetchPosts();
  }, []);

  if (loading) {
    return <div className="text-center py-4">Loading posts...</div>;
  }

  return (
    <div className="space-y-4">
      {posts.length === 0 ? (
        <div className="text-center py-8 text-gray-500">
          No posts yet. Create your first post above!
        </div>
      ) : (
        posts.map((post: Post) => (
          <div key={post._id} className="p-4 border rounded shadow-sm bg-white">
            <h2 className="text-xl font-bold mb-2">{post.title}</h2>
            <p className="text-gray-700 mb-3">{post.content}</p>
            <div className="flex gap-2">
              <button 
                className="px-4 py-1 bg-blue-500 text-white rounded hover:bg-blue-600 transition-colors" 
                onClick={() => onEdit(post)}
              >
                Edit
              </button>
              <button 
                className="px-4 py-1 bg-red-500 text-white rounded hover:bg-red-600 transition-colors" 
                onClick={() => handleDelete(post._id!)}
              >
                Delete
              </button>
            </div>
          </div>
        ))
      )}
    </div>
  );
}
